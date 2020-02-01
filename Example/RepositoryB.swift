//
//  RepositoryB.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

protocol PRepositoryB {
    func foo() -> String
}

class NetworkRepositoryB: PRepositoryB {
    func foo() -> String {
        return "network"
    }
}

class LocalRepositoryB: PRepositoryB {
    func foo() -> String {
        return "local"
    }
}
