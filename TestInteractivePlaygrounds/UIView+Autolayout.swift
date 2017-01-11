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

        self.centerXAnchor.constraint(equalTo: sview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: sview.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: sview.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: sview.heightAnchor).isActive = true
    }
}
