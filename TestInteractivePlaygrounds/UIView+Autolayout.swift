//
//  UIView+Anchor.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 01/02/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func anchorInSuperview()
    {
        guard let sview = self.superview else
        {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false

        self.centerXAnchor.constraintEqualToAnchor(sview.centerXAnchor).active = true
        self.centerYAnchor.constraintEqualToAnchor(sview.centerYAnchor).active = true
        self.widthAnchor.constraintEqualToAnchor(sview.widthAnchor).active = true
        self.heightAnchor.constraintEqualToAnchor(sview.heightAnchor).active = true
    }
}