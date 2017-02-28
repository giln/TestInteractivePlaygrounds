// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import PlaygroundSupport


class MainViewControllerManualLayout : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let kMargin : CGFloat = 10.0
    var imageView : UIImageView?
    var tableView = UITableView(frame: CGRect.zero)
    var allApps : [App] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Start under navigation bar
        self.edgesForExtendedLayout = UIRectEdge()

        // Register TableView Cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Background colors
        self.view.backgroundColor = UIColor.blue
        tableView.backgroundColor = UIColor.white

        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(named: "bus")
        imageView = UIImageView(image: image)

        // Add Subviews
        // self.view.addSubview(imageView!)
        self.view.addSubview(tableView)
        self.tableView.tableHeaderView = imageView!
    }

    override func viewWillAppear(_ animated: Bool)
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
        imgView.frame = CGRect(x: kMargin, y: kMargin, width: self.view.bounds.size.width - kMargin * 2, height: img.size.height)

        self.tableView.frame = CGRect(x: kMargin, y: imgView.frame.maxY, width: self.view.bounds.size.width - kMargin * 2, height: self.view.bounds.size.height - imgView.frame.maxY - kMargin)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allApps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = allApps[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let app = allApps[indexPath.row]

        let detailVc = DetailViewController()
        detailVc.app = app

        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 640, height: 480))

let viewController = MainViewControllerManualLayout()
let navController = UINavigationController(rootViewController: UIViewController())

navController.pushViewController(viewController, animated: false)
window.rootViewController = navController
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = window.rootViewController?.view
