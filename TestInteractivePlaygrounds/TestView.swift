//
//  TestView.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 26/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation
import UIKit

class TestView: UIView
{
    var subView: UIView
    let aSwitch : UISwitch

    override init(frame: CGRect)
    {
        subView = UIView()
        subView.backgroundColor = UIColor.yellowColor()
        aSwitch = UISwitch()

        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()

        self.addSubview(subView)
        self.addSubview(aSwitch)

        aSwitch.addTarget(self, action: "flip", forControlEvents: UIControlEvents.ValueChanged)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()

        subView.frame = self.bounds
        aSwitch.center = self.center
    }

    override func drawRect(rect: CGRect)
    {

        super.drawRect(rect)
    }

    func flip()
    {
        print("flip")

        UIView.animateWithDuration(1.0)
        {
            // self.frame = CGRectMake(0,0,500,500)
        }
    }
}
