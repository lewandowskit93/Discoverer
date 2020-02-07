//
//  Registered.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

/**
 A property wrapper used to register injections into the injectors.
 Example usage:
 @Registered
 var serviceAInjection = Injection<PServiceA>.singleton(ServiceA())
 */
@propertyWrapper
public class Registered<Service> {
    private let injector: Injector
    private let injected: Injection<Service>
    
    public var wrappedValue: Injection<Service> {
        get {
            return injected
        }
    }
    
    public init(wrappedValue: Injection<Service>) {
        self.injector = Injector.default
        self.injected = wrappedValue
        //swiftlint:disable force_try
        try! injector.register(as: Service.self, injection: wrappedValue)
    }

    
    public init(wrappedValue: Injection<Service>, inInjector injector: Injector) {
        self.injector = injector
        self.injected = wrappedValue
        //swiftlint:disable force_try
        try! injector.register(as: Service.self, injection: wrappedValue)
    }
    
    deinit {
        try! injector.unregister(type: Service.self)
    }
}
