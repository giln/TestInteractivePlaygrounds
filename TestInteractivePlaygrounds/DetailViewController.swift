//
//  DetailViewController.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 29/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController : UIViewController
{

    var app : App?
    {
        didSet
        {
            self.title = app?.name
            descriptionLabel.text = app?.appDescription
            self.view.setNeedsLayout()
            self.view.setNeedsDisplay()
        }
    }

    let contentView = UIView(frame: CGRect.zero)
    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        self.view.backgroundColor = UIColor.red
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        contentView.backgroundColor = UIColor.red
        contentView.addSubview(descriptionLabel)

        descriptionLabel.backgroundColor = UIColor.white
        descriptionLabel.numberOfLines = 0
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()

        self.scrollView.frame = self.view.bounds

        let fitSize = descriptionLabel.sizeThatFits(CGSize(width: self.view.bounds.size.width - 20, height: CGFloat(MAXFLOAT)))

        contentView.frame = CGRect(x: 0, y: 0, width: fitSize.width + 20, height: fitSize.height + 20)

        descriptionLabel.frame = CGRect(x: 10, y: 10, width: fitSize.width, height: fitSize.height)

        self.scrollView.contentSize = contentView.bounds.size
    }
}
