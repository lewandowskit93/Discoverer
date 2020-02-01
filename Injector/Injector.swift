//
//  Injector.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

public final class Injector {
    private var singletons: [ObjectIdentifier: Any] = [:]
    
    public func get<T>() throws -> T {
        if let singleton = singletons[ObjectIdentifier(T.self)] as? T {
            return singleton
        } else {
            throw InjectorError.notRegistered
        }
    }
    
    @discardableResult public func register<T>(as: T.Type, singleton: T) throws -> Injector {
        guard !singletons.keys.contains(ObjectIdentifier(T.self)) else {
            throw InjectorError.alreadyRegistered
        }
        singletons[ObjectIdentifier(T.self)] = singleton
        return self
    }
    
    public func unregister<T>(type: T.Type) throws {
        guard singletons.keys.contains(ObjectIdentifier(T.self)) else {
            throw InjectorError.notRegistered
        }
        singletons.removeValue(forKey: ObjectIdentifier(T.self))
    }
}
