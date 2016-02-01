// : Playground - noun: a place where people can play

import UIKit
@testable import ModuleInteractive
import XCPlayground

class MyViewController1 : UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageView : UIImageView?

    var tableView = UITableView(frame: CGRectZero)

    var allApps : [App] = []

    let v = TestView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("viewDidLoad")

        self.edgesForExtendedLayout = .None

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.backgroundColor = UIColor.redColor()

        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage.init(named: "bus")
        imageView = UIImageView.init(image: image)

        imageView?.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(imageView!)

        let margins = view.layoutMarginsGuide

        imageView?.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: 15).active = true

        imageView?.leftAnchor.constraintEqualToAnchor(margins.leftAnchor).active = true

        imageView?.rightAnchor.constraintEqualToAnchor(margins.rightAnchor).active = true

        tableView.topAnchor.constraintEqualToAnchor(imageView!.bottomAnchor, constant: 15).active = true

        tableView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

        tableView.rightAnchor.constraintEqualToAnchor(margins.rightAnchor).active = true

        tableView.leftAnchor.constraintEqualToAnchor(margins.leftAnchor).active = true
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        print("test2")

        RestApiManager.getTopApps
        {
            (apps) in

            self.allApps = apps
            self.tableView.reloadData()

            self.view.setNeedsUpdateConstraints()
        }
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

//----------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let viewController = MyViewController1()
let navController = UINavigationController(rootViewController: viewController)

window.rootViewController = navController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view
