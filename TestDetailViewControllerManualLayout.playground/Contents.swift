// : Playground - noun: a place where people can play

import UIKit

@testable import ModuleInteractive
import PlaygroundSupport


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

    let contentView = UIView(frame: CGRect.zero)
    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        contentView.backgroundColor = UIColor.red
        contentView.addSubview(descriptionLabel)

        descriptionLabel.backgroundColor = UIColor.white
        descriptionLabel.numberOfLines = 0
    }

    override func viewWillAppear(_ animated: Bool)
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

        let fitSize = descriptionLabel.sizeThatFits(CGSize(width: self.view.bounds.size.width - kMargin * 2, height: CGFloat(MAXFLOAT)))

        contentView.frame = CGRect(x: 0, y: 0, width: fitSize.width + kMargin * 2, height: fitSize.height + kMargin * 2)

        descriptionLabel.frame = CGRect(x: kMargin, y: kMargin, width: fitSize.width, height: fitSize.height)

        self.scrollView.contentSize = contentView.bounds.size
    }
}

// ----------------------------------------------

var window: UIWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

let detailViewController = DetailViewControllerManualLayout()

window.rootViewController = detailViewController
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = window.rootViewController?.view

RestApiManager.getTopApps
{ (apps) in

    detailViewController.app = apps[1]
}
