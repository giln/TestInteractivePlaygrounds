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

    var tableView = UITableView(frame: CGRect.zero)

    var allApps : [App] = []

    let v = TestView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.backgroundColor = UIColor.red

        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(named: "bus")
        imageView = UIImageView(image: image)

        self.view.addSubview(imageView!)
        self.view.addSubview(tableView)
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

        guard let imgView = imageView, let img = imageView!.image else
        {
            return
        }

        imgView.frame = CGRect(x: 10, y: 10, width: self.view.bounds.size.width - 20, height: img.size.height) ;

        self.tableView.frame = CGRect(x: 10, y: imgView.frame.maxY, width: self.view.bounds.size.width - 20, height: self.view.bounds.size.height - imgView.frame.maxY - 10)
        print("layout")
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
