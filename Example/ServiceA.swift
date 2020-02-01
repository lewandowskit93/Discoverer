//
//  ServiceA.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

protocol PServiceA {
    func foo()
}

class ServiceA: PServiceA {
    func foo() {
        print("Service A")
    }
}
