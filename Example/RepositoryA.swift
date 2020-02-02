//
//  RepositoryA.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

protocol PRepositoryA {
    func foo() -> Int
}

class RepositoryA: PRepositoryA {
    func foo() -> Int {
        return 1
    }
}
