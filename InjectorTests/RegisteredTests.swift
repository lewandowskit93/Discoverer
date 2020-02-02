//
//  RegisteredTests.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import XCTest
@testable import Injector

final class RegisteredTests: XCTestCase {
    func testRegisteredAttribute_WhenPassedFactory_ShouldRegisterThatFactory() throws {
        struct SUT {
            static let injector = Injector()
            static let instance = Foo()
            @Registered(inInjector: injector)
            var foo = Injection<Foo>.factory({ instance })
        }
        let sut = SUT()
        try XCTAssertTrue(SUT.injector.get(Foo.self) === SUT.instance)
        switch sut.foo {
        case .factory:
            break
        default:
            XCTFail()
        }
    }
    
    func testRegisteredAttribute_WhenPassedSingleton_ShouldRegisterThatSingleton() throws {
        struct SUT {
            static let injector = Injector()
            static let instance = Foo()
            @Registered(inInjector: injector)
            var foo = Injection<Foo>.singleton(instance)
        }
        let sut = SUT()
        try XCTAssertTrue(SUT.injector.get(Foo.self) === SUT.instance)
        switch sut.foo {
        case .singleton:
            break
        default:
            XCTFail()
        }
    }
    
    func testRegisteredAttribute_WhenPassedLazySingleton_ShouldRegisterThatLazySingleton() throws {
        struct SUT {
            static let injector = Injector()
            static let instance = Foo()
            @Registered(inInjector: injector)
            var foo = Injection<Foo>.lazySingleton(nil, {instance})
        }
        let sut = SUT()
        try XCTAssertTrue(SUT.injector.get(Foo.self) === SUT.instance)
        switch sut.foo {
        case .lazySingleton:
            break
        default:
            XCTFail()
        }
    }    
}
