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
        subView.backgroundColor = UIColor.yellow
        aSwitch = UISwitch()

        super.init(frame: frame)
        self.backgroundColor = UIColor.red

        self.addSubview(subView)
        self.addSubview(aSwitch)

        aSwitch.addTarget(self, action: #selector(TestView.flip), for: UIControlEvents.valueChanged)
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

    override func draw(_ rect: CGRect)
    {

        super.draw(rect)
    }

    func flip()
    {
        print("flip")

        UIView.animate(withDuration: 1.0, animations: {
            // self.frame = CGRectMake(0,0,500,500)
        })
        
    }
}
