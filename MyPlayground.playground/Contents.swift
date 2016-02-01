// : Playground - noun: a place where people can play

import UIKit
@testable import ModuleInteractive
import XCPlayground

extension UIImage
{
    convenience init(named: String)
    {
        self.init(named: named, inBundle: NSBundle(forClass : TestView.self), compatibleWithTraitCollection: nil)!
    }
}

class MyViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageView : UIImageView?

    var tableView = UITableView(frame: CGRectZero)

    var allApps : [App] = []

    let v = TestView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        print("viewDidLoad")

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

        // v.addSubview(imageView!)
        // print(imageView)
        self.view.addSubview(imageView!)

        imageView?.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor, constant: 10).active = true

        imageView?.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 10).active = true

        imageView?.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -10).active = true

        tableView.topAnchor.constraintEqualToAnchor(imageView!.bottomAnchor, constant: 10).active = true

        tableView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -10).active = true

        tableView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor, constant: -10).active = true

        tableView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 10).active = true
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

//var window: UIWindow = UIWindow(frame: UIScreen.mainScreen().bounds)

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let nav = UINavigationController(rootViewController: MyViewController())

nav.navigationBar.tintColor = .whiteColor()
nav.view.setNeedsDisplay()

window.rootViewController = nav
window.makeKeyAndVisible()

//vc2.view.frame = CGRectMake(0, 0, 320, 480)

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view

//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

nav.navigationBar
