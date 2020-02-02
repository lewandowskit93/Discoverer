//
//  Injector.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

public final class Injector {
    private var injectables: [ObjectIdentifier: AnyInjectable] = [:]
    public var allowRewrite: Bool
    
    public init(allowRewrite: Bool = false) {
        self.allowRewrite = allowRewrite
    }
    
    public subscript<T>(type: T.Type) -> T? {
        return try? get(as: T.self)
    }
            
    public func get<T>(as type: T.Type = T.self) throws -> T {
        if var injectable = injectables[ObjectIdentifier(T.self)] {
            guard let instance: T = try? injectable.instance(as: T.self) else {
                throw InjectorError.invalidType
            }
            injectables[ObjectIdentifier(T.self)] = injectable
            return instance
        } else {
            throw InjectorError.notRegistered
        }
    }
        
    @discardableResult public func register<T>(as type: T.Type, injectable: Injectable<T>) throws -> Injector {
        try register(as: T.self, injectable: injectable.any())
        return self
    }
    
    @discardableResult public func unregister<T>(type: T.Type) throws -> Injector {
        guard isRegistered(type: type) else {
            throw InjectorError.notRegistered
        }
        injectables.removeValue(forKey: ObjectIdentifier(T.self))
        return self
    }
        
    public func isRegistered<T>(type: T.Type) -> Bool {
        return injectables.keys.contains(ObjectIdentifier(T.self))
    }
    
    @discardableResult private func register<T>(as type: T.Type, injectable: AnyInjectable) throws -> Injector {
        guard !isRegistered(type: type) || allowRewrite else {
            throw InjectorError.alreadyRegistered
        }
        injectables[ObjectIdentifier(T.self)] = injectable
        return self
    }
}
