//
//  Environment.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct Environment {
    static var services: Injector = Injector()
    static var repositories: Injector = Injector()
}
