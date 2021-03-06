//
//  Injected.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

/**
+ A property wrapper used to retrieve injected service from injector.
+ Example usage:
+ @Injected
+ var serviceAInjection: PService
+ */
@propertyWrapper
public class Injected<Service> {
    private let injector: Injector
    
    public var wrappedValue: Service {
        //swiftlint:disable force_try
        return try! injector.get(Service.self)
    }
    
    public init() {
        self.injector = Injector.default
    }
    
    public init(injector: Injector) {
        self.injector = injector
    }
}
