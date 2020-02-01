//
//  ServiceConfigurator.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct ServiceConfigurator {
    static func configure(injector: Injector) throws {
        try Environment.injector.register(as: PFoo.self, singleton: Bar())
    }
}
