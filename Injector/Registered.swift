//
//  Registered.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

@propertyWrapper
public class Registered<Service> {
    private let injector: Injector
    
    public var wrappedValue: AnyInjection {
        //swiftlint:disable force_try
        return try! injector.getInjection(Service.self)
    }
    
    public init(wrappedValue: AnyInjection, asType type: Service.Type, inInjector injector: Injector) {
        self.injector = injector
        try! injector.register(as: Service.self, injection: wrappedValue)
    }
}

