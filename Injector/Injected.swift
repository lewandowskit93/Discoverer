//
//  Injected.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

@propertyWrapper
public class Injected<Service> {
    private let injector: Injector
    
    public var wrappedValue: Service {
        get {
            return injector.unsafeGet()
        }
    }
    
    public init(injector: Injector) {
        self.injector = injector
    }
}
