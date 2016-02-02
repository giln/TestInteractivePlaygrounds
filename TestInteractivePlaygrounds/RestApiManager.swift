//
//  RestApiManager.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 28/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation

typealias ServiceResponse = (NSData?, NSError?) -> Void

typealias Payload = [String: AnyObject]

class RestApiManager: NSObject
{

    class func getTopApps(onCompletion: [App] -> Void)
    {
        let baseURL = "http://itunes.apple.com/fr/rss/toppaidapplications/limit=50/json"

        makeHTTPGetRequest(baseURL, onCompletion:
        {
            data, error in

            guard let data1 = data else
            {
                onCompletion([])
                return
            }

            let json = try! NSJSONSerialization.JSONObjectWithData(data1, options: .AllowFragments)

            guard let feed = json["feed"] as? Payload, let apps = feed["entry"] as? [AnyObject] else
            {
                onCompletion([])
                return
            }

            var allApps: [App] = []

            for app in apps
            {
                guard let container = app["im:name"] as? Payload, let name = container["label"] as? String else
                {
                    continue
                }

                guard let id = app["id"] as? Payload, let link = id["label"] as? String else
                {
                    continue
                }

                guard let desc = app["summary"] as? Payload, let appDescription = desc["label"] as? String else
                {
                    continue
                }

                let appstoreApp = App(name: name, link: link, description: appDescription)

                allApps.append(appstoreApp)
            }

            onCompletion(allApps)
        })
    }

    class func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(request, completionHandler:
        {
            data, response, error -> Void in

            dispatch_async(dispatch_get_main_queue(),
            {
                onCompletion(data, error)
            })
        })
        task.resume()
    }
}
