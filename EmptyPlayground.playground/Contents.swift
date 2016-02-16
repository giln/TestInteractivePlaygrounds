// : Playground - noun: a place where people can play

import UIKit
import XCPlayground

class FloatingTableView : UITableView
{
    var stickyHeaderView : UIView?
    {
        didSet
        {
            // the content is inset with the view height
            self.contentInset = UIEdgeInsetsMake(stickyHeaderView!.bounds.size.height, 0, 0, 0)
            self.addSubview(stickyHeaderView!)

        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if let stickyView = self.stickyHeaderView
        {
            // We need to bring the sticky view above the section views but below scroll indicator view
            if let sectionView = self.headerViewForSection(0)
            {
                self.insertSubview(stickyView, aboveSubview: sectionView)
            }
            
            var headerOffset = CGFloat(0)
            
            if var tableHeaderViewFrame = self.tableHeaderView?.frame
            {
                // Change frame of tableHeaderView
                headerOffset = tableHeaderViewFrame.maxY
                
                tableHeaderViewFrame.origin.y -= stickyView.bounds.size.height
                self.tableHeaderView?.frame = tableHeaderViewFrame
            }
            
            // Set frame of sticky view
            stickyView.frame = CGRectMake(0,max(headerOffset-stickyView.bounds.size.height,contentOffset.y),self.bounds.size.width,stickyView.bounds.size.height)
            
        }
    }
}

class FloatingSectionsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let tableView = FloatingTableView()
    
    let data = [["1", "2", "3", "4", "5","6","7"], ["1", "2", "3", "4", "5", "6", "7"], ["1", "2", "3", "4", "5", "6", "7"]]
    let sections = ["A", "B", "C"]
    
    let stickyView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        // Register TableView Cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerCell")
        
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        redView.backgroundColor = UIColor.redColor()
        
        stickyView.backgroundColor = UIColor.yellowColor()
        
        tableView.tableHeaderView = redView
        tableView.stickyHeaderView = stickyView
        
        
        // Background colors
        self.view.backgroundColor = UIColor.redColor()
        tableView.backgroundColor = UIColor.whiteColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerCell")!
            
            headerCell.textLabel?.text = sections[section]
            headerCell.contentView.backgroundColor = UIColor.darkGrayColor()
        
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40.0
    }
    
   
    
}

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let detailViewController = FloatingSectionsViewController()

window.rootViewController = detailViewController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view
