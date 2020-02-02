//
//  ServiceB.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

protocol PServiceB {
    func foo()
}

class ServiceB: PServiceB {
    func foo() {
        print("Service B")
    }
}
