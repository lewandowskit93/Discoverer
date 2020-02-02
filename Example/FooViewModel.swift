//
//  FooViewModel.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct FooViewModel {
    @Injected(injector: Environment.services) var serviceA: PServiceA
    @Injected(injector: Environment.services) var serviceB: PServiceB
    @Injected(injector: Environment.repositories) var repositoryA: PRepositoryA
    @Injected(injector: Environment.repositories) var repositoryB: PRepositoryB
    
    func viewDidLoad() {
        serviceA.foo()
        serviceB.foo()
        print(repositoryA.foo())
        print(repositoryB.foo())
    }
}
