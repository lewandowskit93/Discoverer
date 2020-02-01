//
//  BarViewModel.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct BarViewModel {
    @Injected(injector: Environment.injector) var foo: PFoo
}
