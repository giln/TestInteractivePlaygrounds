//
//  ViewController.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 26/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageView : UIImageView?

    var tableView = UITableView(frame: CGRectZero)

    var allApps : [App] = []

    let v = TestView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.backgroundColor = UIColor.redColor()

        tableView.backgroundColor = UIColor.whiteColor()
        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(named: "bus")
        imageView = UIImageView(image: image)

        self.view.addSubview(imageView!)
        self.view.addSubview(tableView)
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        RestApiManager.getTopApps
        {
            (apps) in

            self.allApps = apps
            self.tableView.reloadData()

            self.view.setNeedsLayout()
        }
    }

    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()

        guard let imgView = imageView, let img = imageView!.image else
        {
            return
        }

        imgView.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, img.size.height) ;

        self.tableView.frame = CGRectMake(10, CGRectGetMaxY(imgView.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height - CGRectGetMaxY(imgView.frame) - 10)
        print("layout")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allApps.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = allApps[indexPath.row].name

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let app = allApps[indexPath.row]

        print(app)

        let detailVc = DetailViewController()
        detailVc.app = app

        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}