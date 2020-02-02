//
//  RepositoryConfiguration.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Discoverer

struct RepositoryConfiguration {
    static func configure(injector: Injector) throws {
        _ = try? Environment.repositories
            .register(as: PRepositoryA.self, injection: .lazySingleton(nil, { RepositoryA() }))
            .register(as: PRepositoryB.self, injection: .singleton(LocalRepositoryB()))
            .unregister(type: PRepositoryB.self)
            .register(as: PRepositoryB.self, injection: .singleton(NetworkRepositoryB()))
    }
}
