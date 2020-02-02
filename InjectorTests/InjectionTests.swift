//
//  InjectionTests.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import XCTest
@testable import Injector

final class InjectionTests: XCTestCase {
    func testInstance_WhenCreatedWithSingleton_ShouldReturnThatInstance() {
        let instance = Foo()
        var sut = Injection.singleton(instance)
        XCTAssertTrue(sut.instance() === instance)
    }
    
    func testInstance_WhenCreatedWithFactory_ShouldReturnCorrectInstance() {
        let instance = Foo()
        var sut = Injection.factory({ return instance })
        XCTAssertTrue(sut.instance() === instance)
    }
    
    func testInstance_WhenCreatedWithLazySingleton_ShouldAlwaysReturnSameSingleton() {
        var sut = Injection.lazySingleton(nil, { return Foo() })
        let firstInstance = sut.instance()
        let secondInstance = sut.instance()
        XCTAssertTrue(firstInstance === secondInstance)
    }
    
    func testAny_WhenCalledForSingleton_ShouldReturnSingletonAnyInjectionWithSameInstance() throws {
        let instance = Foo()
        let sut = Injection.singleton(instance)
        var any = sut.any()
        switch any {
        case .singleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injection type")
        }
    }
    
    func testAny_WhenCalledForFactory_ShouldReturnFactoryAnyInjectionWithSameFactory() throws {
        let instance = Foo()
        let factory = { instance }
        let sut = Injection.factory(factory)
        var any = sut.any()
        switch any {
        case .factory:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injection type")
        }
    }
    
    func testAny_WhenCalledForLazySingleton_ShouldReturnLazySingletonInjectionWithSameFactory() throws {
        let instance = Foo()
        let factory = { instance }
        let sut = Injection.lazySingleton(nil, factory)
        var any = sut.any()
        switch any {
        case .lazySingleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injection type")
        }
    }
    
    func testAny_WhenCalledForLazySingleton_ShouldReturnLazySingletonInjectionWithSameInstance() throws {
        let instance = Foo()
        let factoryInstance = Foo()
        let factory = { factoryInstance }
        let sut = Injection.lazySingleton(instance, factory)
        var any = sut.any()
        switch any {
        case .lazySingleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injection type")
        }
    }
}
