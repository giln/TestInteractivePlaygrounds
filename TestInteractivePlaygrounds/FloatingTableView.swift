//
//  FloatingTableView.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 16/02/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation

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
            stickyView.frame = CGRectMake(0, max(headerOffset - stickyView.bounds.size.height, contentOffset.y), self.bounds.size.width, stickyView.bounds.size.height)
        }
    }
}