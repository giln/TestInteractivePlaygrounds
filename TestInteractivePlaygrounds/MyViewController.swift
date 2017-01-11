//
//  ViewController.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 26/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class MyViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageView : UIImageView?

    var tableView = UITableView(frame: CGRect.zero)

    var allApps : [App] = []

    let v = TestView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.backgroundColor = UIColor.red

        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage.init(named: "bus")
        imageView = UIImageView.init(image: image)

        imageView?.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(imageView!)
        self.view.addSubview(tableView)

        let margins = view.layoutMarginsGuide

        imageView?.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true

        imageView?.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        imageView?.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 10).isActive = true

        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        tableView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool)
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

        print(app)

        let detailVc = DetailViewController()
        detailVc.app = app

        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
