//
//  Injector.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

public final class Injector {
    private var injections: [ObjectIdentifier: AnyInjection] = [:]
    public var allowRewrite: Bool
    
    public init(allowRewrite: Bool = false) {
        self.allowRewrite = allowRewrite
    }
    
    public subscript<T>(type: T.Type) -> T? {
        return try? get(T.self)
    }
            
    public func get<T>(_ type: T.Type = T.self) throws -> T {
        guard var injection = injections[ObjectIdentifier(T.self)] else {
            throw InjectorError.notRegistered
        }
        let instance: T = try injection.instance(as: T.self)
        injections[ObjectIdentifier(T.self)] = injection
        return instance
    }
    
    @discardableResult public func register<T>(as type: T.Type, injection: Injection<T>) throws -> Injector {
        try register(as: T.self, injection: injection.any())
        return self
    }
    
    @discardableResult public func unregister<T>(type: T.Type) throws -> Injector {
        guard isRegistered(type: type) else {
            throw InjectorError.notRegistered
        }
        injections.removeValue(forKey: ObjectIdentifier(T.self))
        return self
    }
        
    public func isRegistered<T>(type: T.Type) -> Bool {
        return injections.keys.contains(ObjectIdentifier(T.self))
    }
        
    @discardableResult private func register<T>(as type: T.Type, injection: AnyInjection) throws -> Injector {
        guard !isRegistered(type: type) || allowRewrite else {
            throw InjectorError.alreadyRegistered
        }
        injections[ObjectIdentifier(T.self)] = injection
        return self
    }
}
