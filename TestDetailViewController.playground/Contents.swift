// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import XCPlayground

class DetailViewController1 : UIViewController
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

    let contentView = UIView(frame: CGRectZero)
    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        self.view.backgroundColor = UIColor.redColor()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        contentView.backgroundColor = UIColor.redColor()
        contentView.addSubview(descriptionLabel)

        descriptionLabel.backgroundColor = UIColor.whiteColor()
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

        let fitSize = descriptionLabel.sizeThatFits(CGSizeMake(self.view.bounds.size.width - 20, CGFloat(MAXFLOAT)))

        contentView.frame = CGRectMake(0, 0, fitSize.width + 20, fitSize.height + 20)

        descriptionLabel.frame = CGRectMake(10, 10, fitSize.width, fitSize.height)

        self.scrollView.contentSize = contentView.bounds.size
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRectMake(0, 0, 320, 480))

let detailViewController = DetailViewController1()

window.rootViewController = detailViewController
window.makeKeyAndVisible()

XCPlaygroundPage.currentPage.liveView = window.rootViewController?.view

RestApiManager.getTopApps
{ (apps) in

    detailViewController.app = apps[1]
}
