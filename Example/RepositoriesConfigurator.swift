//
//  RepositoriesConfigurator.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct RepositoriesConfigurator {
    static func configure(injector: Injector) throws {
        _ = try? Environment.repositories
            .register(as: PRepositoryA.self, injectable: .lazySingleton(nil, { RepositoryA() }))
            .register(as: PRepositoryB.self, injectable: .singleton(LocalRepositoryB()))
            .unregister(type: PRepositoryB.self)
            .register(as: PRepositoryB.self, injectable: .singleton(NetworkRepositoryB()))
    }
}
