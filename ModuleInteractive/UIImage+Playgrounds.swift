//
//  UIImage+Playgrounds.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 01/02/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage
{
    convenience init(named: String)
    {
        self.init(named: named, inBundle: NSBundle(forClass :  MainViewController.self), compatibleWithTraitCollection: nil)!
    }
}