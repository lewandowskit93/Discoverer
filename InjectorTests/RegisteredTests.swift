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
            @Registered(asType: Foo.self, inInjector: injector)
            var foo = Injection<Foo>.factory({ instance }).any()
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
            @Registered(asType: Foo.self, inInjector: injector)
            var foo = Injection<Foo>.singleton(instance).any()
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
            @Registered(asType: Foo.self, inInjector: injector)
            var foo = Injection<Foo>.lazySingleton(nil, {instance}).any()
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
    
    func testRegisteredIncorrectly_WhenInstanceAccessed_ShouldThrowError() {
        struct SUT {
            static let injector = Injector()
            static let instance = Foo()
            @Registered(asType: Bar.self, inInjector: injector)
            var foo = Injection<Foo>.factory({ instance }).any()
        }
        _ = SUT()
        do {
            try _ = SUT.injector.get(Bar.self)
            XCTFail("expected to throw error")
        } catch InjectorError.invalidType {
            // nothing to do
        } catch {
            XCTFail("invalid error thrown")
        }
    }
}
