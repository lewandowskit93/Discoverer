//
//  Injection.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

///  Represents a single dependency injection
public enum Injection<T> {
    public typealias Factory = () -> T
    /// Returns the same instance
    case singleton(_ value: T)
    /// Returns the same instance created lazily on demand
    case lazySingleton( _ value: T?, _ factory: Factory)
    /// Returns new instance each time instance is accessed
    case factory(_ factory: Factory)
    
    /// Returns instance held by injection and creates new one if necessarily
    mutating public func instance() -> T {
        switch self {
        case .singleton(let value):
            return value
        case .factory(let factory):
            return factory()
        case .lazySingleton(let instance, let factory):
            let newInstance = instance ?? factory()
            self = .lazySingleton(newInstance, factory)
            return newInstance
        }
    }
}

internal extension Injection {
    func any() -> AnyInjection {
        switch self {
        case .singleton(let value):
            return .singleton(value)
        case .lazySingleton(let value, let factory):
            return .lazySingleton(value, factory)
        case .factory(let factory):
            return .factory(factory)
        }
    }
}
