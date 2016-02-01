//
//  App.swift
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 28/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import Foundation

struct App
{
    let name: String
    let link: String
    let appDescription : String

    init(name: String, link: String, description: String)
    {
        self.name = name
        self.link = link
        self.appDescription = description
    }
}