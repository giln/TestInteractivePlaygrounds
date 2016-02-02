// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import XCPlayground

class DetailViewControllerManualLayout : UIViewController
{
    let kMargin : CGFloat = 10.0

    var app : App?
    {
        didSet
        {
            self.title = app?.name
            descriptionLabel.text = app?.appDescription
            self.view.setNeedsLayout()
        }
    }

    let contentView = UIView(frame: CGRectZero)
    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        contentView.backgroundColor = UIColor.redColor()
        contentView.addSubview(descriptionLabel)

        descriptionLabel.backgroundColor = UIColor.whiteColor()
        descriptionLabel.numberOfLines = 0
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()

        self.scrollView.frame = self.view.bounds

        let fitSize = descriptionLabel.sizeThatFits(CGSizeMake(self.view.bounds.size.width - kMargin * 2, CGFloat(MAXFLOAT)))

        contentView.frame = CGRectMake(0, 0, fitSize.width + kMargin * 2, fitSize.height + kMargin * 2)

        descriptionLabel.frame = CGRectMake(kMargin, kMargin, fitSize.width, fitSize.height)

        self.scrollView.contentSize = contentView.bounds.size
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let detailViewController = DetailViewControllerManualLayout()

window.rootViewController = detailViewController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view

RestApiManager.getTopApps
{ (apps) in

    detailViewController.app = apps[1]
}
