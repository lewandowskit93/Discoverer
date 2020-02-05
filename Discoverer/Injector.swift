//
//  Injector.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

/*** Represents a single dependency injection container.
 Injections can be registered in injector by using either register method or Register property wrapper.
 */
public final class Injector {
    /// Default dependency injection container
    public static var `default`: Injector = Injector()
    
    private var injections: [ObjectIdentifier: AnyInjection] = [:]
    
    /// If true it allows injections to be rewritten.
    public var allowRewrite: Bool
    
    /// Creates a dependnecy injection container
    public init(allowRewrite: Bool = false) {
        self.allowRewrite = allowRewrite
    }
    
    /// Returns injected service if exists or nil otherwise
    public subscript<T>(type: T.Type) -> T? {
        return try? get(T.self)
    }
    
    /// Returns injected service if exists or throw an error otherwise
    public func get<T>(_ type: T.Type = T.self) throws -> T {
        guard var injection = injections[ObjectIdentifier(T.self)] else {
            throw InjectorError.notRegistered
        }
        let instance: T = try injection.instance(as: T.self)
        injections[ObjectIdentifier(T.self)] = injection
        return instance
    }
    
    /*** Registers given injection in the container
    Example usage:
        _ = try? services
            .register(as: PServiceA.self, injectable: .factory({ ServiceA() }))
    */
    @discardableResult public func register<T>(as type: T.Type, injection: Injection<T>) throws -> Injector {
        try register(as: T.self, injection: injection.any())
        return self
    }
    
    /// Unregisters a service of a given type
    @discardableResult public func unregister<T>(type: T.Type) throws -> Injector {
        guard isRegistered(type: type) else {
            throw InjectorError.notRegistered
        }
        injections.removeValue(forKey: ObjectIdentifier(T.self))
        return self
    }
    
    /// Returns true if service of a given type is available
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
