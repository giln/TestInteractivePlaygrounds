//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
@testable import ModuleInteractive


extension App
{
    init?(json: [String: Any])
    {
        guard let container = json["im:name"] as? [String: Any],
            let name = container["label"] as? String,
            let id = json["id"] as? [String: Any],
            let link = id["label"] as? String,
            let summary = json["summary"] as? [String: Any],
            let summaryLabel = summary["label"] as? String
            else
        {
            return nil
        }

        self.name = name
        self.link = link
        self.appDescription = summaryLabel
    }
}

class AppStoreService
{
    typealias AppStoreServiceResponse = (error: Error?, values: [Any]?)
    
    struct Constants
    {
        static let baseURL = "http://itunes.apple.com/fr/rss/toppaidapplications/limit=20/json"
    }
    
    static func getTopApps(completion:@escaping (AppStoreServiceResponse) -> Void )
    {
        let session = URLSession.shared
        if let url = URL(string: Constants.baseURL)
        {
            let task = session.dataTask(with: url)
            {
                (data, response, error) in
                
                var apps = [App]()
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let existingJson = json,
                    let feed = existingJson["feed"] as? [String: Any],
                    let entries = feed["entry"] as? [Any]
                {
                    for entry in entries
                    {
                        if let entryDic = entry as? [String:Any],
                            let app = App(json: entryDic)
                        {
                            apps.append(app)
                        }
                    }
                }
                
                DispatchQueue.main.async
                {
                    completion((error:error ,values: apps))
                }
                
            
            }
            
            task.resume()
        }
    }
}

class SomeViewController : UITableViewController
{
    var topApps = [App]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        title = "Top Apps"
        
        // Register TableView Cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
        AppStoreService.getTopApps { serviceResponse in
            if let error = serviceResponse.error
            {
                print("\(error.localizedDescription)")
            }
    
            if let apps = serviceResponse.values as? [App]
            {
                self.topApps = apps
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topApps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = topApps[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = topApps[indexPath.row]
        
        let detailVc = DetailViewController()
        detailVc.app = app
        
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}


let controller = SomeViewController()

let navController = UINavigationController(rootViewController: controller)

let device = UIViewController.Device.phone5_5inch
let orientation = UIViewController.Orientation.portrait

let (parent, _) = UIViewController.playgroundControllers(device: device, orientation: orientation, child: navController)

PlaygroundPage.current.liveView = parent.view


