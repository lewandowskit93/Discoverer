//
//  Environment.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct Environment: PInjectorProvider {
    static let injector: Injector = Injector()
}
