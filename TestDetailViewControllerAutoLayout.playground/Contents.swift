// : Playground - noun: a place where people can play

import UIKit
@testable import ModuleInteractive
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

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

            scrollView.contentSize = CGSize(width:descriptionLabel.bounds.size.width + kMargin * 2, height: descriptionLabel.bounds.size.height + kMargin * 2)
        }
    }

    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blue

        self.view.addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)

        // Colors
        scrollView.backgroundColor = UIColor.yellow
        descriptionLabel.backgroundColor = UIColor.white

        descriptionLabel.numberOfLines = 0

        // Autolayout setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout
        scrollView.anchorInSuperview()

        descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: kMargin).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: kMargin).isActive = true
    }

    override func viewWillAppear(_ animated: Bool)
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

let detailViewController = DetailViewControllerAutoLayout()

 print("titi")

RestApiManager.getTopApps
    { (apps) in
        
        print("toto")
        
        detailViewController.app = apps[1]
}

print("tata")



PlaygroundPage.current.liveView = detailViewController

