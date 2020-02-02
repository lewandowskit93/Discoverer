//
//  AppConfiguration.swift
//  Example
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

struct AppConfiguration {
    let serviceConfiguration = ServiceConfiguration()
    let repositoryConfiguration = RepositoryConfiguration()
    
    func configure() {
        //swiftlint:disable force_try
        try! RepositoryConfiguration.configure(injector: Environment.repositories)
    }
}
