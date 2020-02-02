//
//  InjectableTests.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import XCTest
@testable import Injector

final class InjectableTests: XCTestCase {
    func testInstance_WhenCreatedWithSingleton_ShouldReturnThatInstance() {
        let instance = Foo()
        var sut = Injectable.singleton(instance)
        XCTAssertTrue(sut.instance() === instance)
    }
    
    func testInstance_WhenCreatedWithFactory_ShouldReturnCorrectInstance() {
        let instance = Foo()
        var sut = Injectable.factory({ return instance })
        XCTAssertTrue(sut.instance() === instance)
    }
    
    func testInstance_WhenCreatedWithLazySingleton_ShouldAlwaysReturnSameSingleton() {
        var sut = Injectable.lazySingleton(nil, { return Foo() })
        let firstInstance = sut.instance()
        let secondInstance = sut.instance()
        XCTAssertTrue(firstInstance === secondInstance)
    }
    
    func testAny_WhenCalledForSingleton_ShouldReturnSingletonAnyInjectableWithSameInstance() throws {
        let instance = Foo()
        let sut = Injectable.singleton(instance)
        var any = sut.any()
        switch any {
        case .singleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injectable type")
        }
    }
    
    func testAny_WhenCalledForFactory_ShouldReturnFactoryAnyInjectableWithSameFactory() throws {
        let instance = Foo()
        let factory = { instance }
        let sut = Injectable.factory(factory)
        var any = sut.any()
        switch any {
        case .factory:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injectable type")
        }
    }
    
    func testAny_WhenCalledForLazySingleton_ShouldReturnLazySingletonInjectableWithSameFactory() throws {
        let instance = Foo()
        let factory = { instance }
        let sut = Injectable.lazySingleton(nil, factory)
        var any = sut.any()
        switch any {
        case .lazySingleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injectable type")
        }
    }
    
    func testAny_WhenCalledForLazySingleton_ShouldReturnLazySingletonInjectableWithSameInstance() throws {
        let instance = Foo()
        let factoryInstance = Foo()
        let factory = { factoryInstance }
        let sut = Injectable.lazySingleton(instance, factory)
        var any = sut.any()
        switch any {
        case .lazySingleton:
            try XCTAssertTrue(instance === any.instance(as: Foo.self))
        default:
            XCTFail("Invalid injectable type")
        }
    }
}
