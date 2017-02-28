// : Playground - noun: a place where people can play

import UIKit
@testable import ModuleInteractive
import PlaygroundSupport

class MyViewController1 : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let kMargin : CGFloat = 15.0
    var imageView : UIImageView?
    var tableView = UITableView(frame: CGRect.zero)
    var allApps : [App] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Start below navigationbar
        self.edgesForExtendedLayout = UIRectEdge()

        // Register cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage.init(named: "bus")
        imageView = UIImageView.init(image: image)

        // Add subviews
        self.view.addSubview(imageView!)
        self.view.addSubview(tableView)

        // Autolayout
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let margins = self.view.layoutMarginsGuide

        imageView?.topAnchor.constraint(equalTo: margins.topAnchor, constant: kMargin).isActive = true
        imageView?.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        imageView?.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: kMargin).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

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

//----------------------------------

var window: UIWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 700, height: 540))

let viewController = MyViewController1()
let navController = UINavigationController(rootViewController: viewController)

window.rootViewController = navController
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = viewController.view
