// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import XCPlayground

class MainViewController1 : UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageView : UIImageView?

    var tableView = UITableView(frame: CGRectZero)

    var allApps : [App] = []

    let v = TestView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        print("init")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        
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

        guard let imgView = imageView else
        {
            return
        }

        imgView.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, (imgView.image?.size.height)!)

        self.tableView.frame = CGRectMake(10, CGRectGetMaxY(imgView.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height - CGRectGetMaxY(imgView.frame) - 10)
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

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let viewController = MainViewController1()
let navController = UINavigationController(rootViewController: UIViewController())

navController.pushViewController(viewController, animated: false)
window.rootViewController = navController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view
