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
        _ = try? Environment.injector.register(as: PFoo.self, injectable: .lazySingleton(nil, { Foo() }))
        _ = try? Environment.injector.unregister(type: PFoo.self)
        _ = try? Environment.injector.register(as: PFoo.self, injectable: .factory({ Bar() }))
    }
}
