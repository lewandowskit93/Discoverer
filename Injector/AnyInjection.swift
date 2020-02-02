//
//  AnyInjection.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

internal enum AnyInjection {
    public typealias Factory = () -> Any
    case singleton(_ value: Any)
    case lazySingleton(_ value: Any?, _ factory: Factory)
    case factory(_ factory: Factory)
    
    internal mutating func instance<T>(as: T.Type) throws -> T {
        switch self {
        case .singleton(let value):
            guard let singleton = value as? T else { throw InjectorError.invalidType }
            return singleton
        case .factory(let factory):
            guard let instance = factory() as? T else { throw InjectorError.invalidType }
            return instance
        case .lazySingleton(let instance, let factory):
            if instance != nil {
                guard let instance = instance as? T else { throw InjectorError.invalidType }
                return instance
            } else {
                guard let instance = factory() as? T else { throw InjectorError.invalidType }
                self = .lazySingleton(instance, factory)
                return instance
            }
        }
    }
}
