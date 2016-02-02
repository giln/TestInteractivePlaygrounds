// : Playground - noun: a place where people can play

import UIKit
@testable import ModuleInteractive
import XCPlayground

class DetailViewControllerAutoLayout : UIViewController
{
    let kMargin : CGFloat = 10.0

    var app : App?
    {
        didSet
        {
            self.title = app?.name
            descriptionLabel.text = app?.appDescription
            self.view.setNeedsUpdateConstraints()

            scrollView.contentSize = CGSizeMake(descriptionLabel.bounds.size.width + kMargin * 2, descriptionLabel.bounds.size.height + kMargin * 2)
        }
    }

    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blueColor()

        self.view.addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)

        // Colors
        scrollView.backgroundColor = UIColor.yellowColor()
        descriptionLabel.backgroundColor = UIColor.whiteColor()

        descriptionLabel.numberOfLines = 0

        // Autolayout setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout
        scrollView.anchorInSuperview()

        descriptionLabel.topAnchor.constraintEqualToAnchor(scrollView.topAnchor, constant: kMargin).active = true
        descriptionLabel.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor, constant: kMargin).active = true
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints()
    {
        super.updateViewConstraints()

        // can't do this in viewDidLoad because view bounds are Zero
        descriptionLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - kMargin * 2
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let detailViewController = DetailViewControllerAutoLayout()

window.rootViewController = detailViewController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view

RestApiManager.getTopApps
{ (apps) in

    detailViewController.app = apps[1]
}
