//
//  FloatingSectionsViewController.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 03/02/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation
import UIKit
class FloatingSectionsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let tableView = FloatingTableView()
    
    let data = [["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]]
    let sections = ["A", "B", "C"]
    
    let stickyView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        // Register TableView Cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerCell")
        
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        redView.backgroundColor = UIColor.red
        
        stickyView.backgroundColor = UIColor.yellow
        
        tableView.tableHeaderView = redView
        tableView.stickyHeaderView = stickyView
        
        // Background colors
        self.view.backgroundColor = UIColor.red
        tableView.backgroundColor = UIColor.white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.section] [indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell")!
        
        headerCell.textLabel?.text = sections[section]
        headerCell.contentView.backgroundColor = UIColor.darkGray
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40.0
    }
}
