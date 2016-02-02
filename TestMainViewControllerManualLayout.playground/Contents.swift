// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import XCPlayground

class MainViewControllerManualLayout : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let kMargin : CGFloat = 10.0
    var imageView : UIImageView?
    var tableView = UITableView(frame: CGRectZero)
    var allApps : [App] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Start under navigation bar
        self.edgesForExtendedLayout = .None

        // Register TableView Cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Background colors
        self.view.backgroundColor = UIColor.redColor()
        tableView.backgroundColor = UIColor.whiteColor()

        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(named: "bus")
        imageView = UIImageView(image: image)

        // Add Subviews
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

        guard let imgView = imageView, let img = imgView.image else
        {
            return
        }

        // All layout happens here
        imgView.frame = CGRectMake(kMargin, kMargin, self.view.bounds.size.width - kMargin * 2, img.size.height)

        self.tableView.frame = CGRectMake(kMargin, CGRectGetMaxY(imgView.frame), self.view.bounds.size.width - kMargin * 2, self.view.bounds.size.height - CGRectGetMaxY(imgView.frame) - kMargin)
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

        let detailVc = DetailViewController()
        detailVc.app = app

        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let viewController = MainViewControllerManualLayout()
let navController = UINavigationController(rootViewController: UIViewController())

navController.pushViewController(viewController, animated: false)
window.rootViewController = navController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view
