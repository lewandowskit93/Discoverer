//
//  Injector.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

public final class Injector {
    public typealias Factory = () -> Any
    private var singletons: [ObjectIdentifier: Any] = [:]
    private var lazySingletons: [ObjectIdentifier: Factory] = [:]
    private var factories: [ObjectIdentifier: Factory] = [:]
    
    public init() {
        
    }
    
    public subscript<T>(type: T.Type) -> T {
        get {
            return unsafeGet()
        }
        set (newValue) {
            //swiftlint:disable force_try
            try! register(as: T.self, singleton: newValue)
        }
    }
    
    public func unsafeGet<T>() -> T {
        //swiftlint:disable force_try
        return try! get()
    }
    
    public func get<T>() throws -> T {
        if let singleton = singletons[ObjectIdentifier(T.self)] as? T {
            return singleton
        } else {
            throw InjectorError.notRegistered
        }
    }
    
    @discardableResult public func register<T>(as type: T.Type, singleton: T) throws -> Injector {
        guard !isRegistered(type: type) else {
            throw InjectorError.alreadyRegistered
        }
        singletons[ObjectIdentifier(T.self)] = singleton
        return self
    }
        
    @discardableResult public func register<T>(as type: T.Type, lazySingleton: @escaping () -> T) throws -> Injector {
        guard !isRegistered(type: type) else {
            throw InjectorError.alreadyRegistered
        }
        lazySingletons[ObjectIdentifier(T.self)] = lazySingleton
        return self
    }
    
    @discardableResult public func register<T>(as type: T.Type, factory: @escaping () -> T) throws -> Injector {
        guard !isRegistered(type: type) else {
            throw InjectorError.alreadyRegistered
        }
        factories[ObjectIdentifier(T.self)] = factory
        return self
    }
    
    public func unregister<T>(type: T.Type) throws -> Injector {
        guard isRegistered(type: type) else {
            throw InjectorError.notRegistered
        }
        singletons.removeValue(forKey: ObjectIdentifier(T.self))
        return self
    }
    
    public func isRegistered<T>(type: T.Type) -> Bool {
        return singletons.keys.contains(ObjectIdentifier(T.self))
            || lazySingletons.keys.contains(ObjectIdentifier(T.self))
            || factories.keys.contains(ObjectIdentifier(T.self))
    }
}
