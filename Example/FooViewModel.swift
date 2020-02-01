//
//  FooViewModel.swift
//  FooViewModel
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct FooViewModel<InjectorProvider: PInjectorProvider> {
    @Injected(injector: InjectorProvider.injector) var foo: PFoo
}
