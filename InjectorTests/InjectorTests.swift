//
//  InjectorTests.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import XCTest
@testable import Injector

final class InjectorTests: XCTestCase {
    
    var sut: Injector!
    
    override func setUp() {
        sut = Injector()
        super.setUp()
    }
    
    func testGet_WhenRegisteredWithConcreteTypeSingleton_ShouldReturnInstance() throws {
        let foo = Foo()
        try sut.register(as: Foo.self, injectable: .singleton(foo))
        let _: Foo = try sut.get(as: Foo.self)
    }
    
    func testGet_WhenRegisteredWithProtocolSingleton_ShouldReturnInstance() throws {
        let foo = Foo()
        try sut.register(as: PFoo.self, injectable: .singleton(foo))
        let _: PFoo = try sut.get(as: PFoo.self)
    }
    
    func testGet_WhenRegisteredWithLazySingleton_ShouldAlwaysReturnSameInstance() throws {
        try sut.register(as: Foo.self, injectable: .lazySingleton(nil, { Foo() }))
        let instance1: Foo = try sut.get()
        let instance2: Foo = try sut.get()
        XCTAssertNotNil(instance1)
        XCTAssertTrue(instance1 === instance2)
    }
    
    func testSubscript_WhenNotRegistered_ShouldReturnNil() throws {
        let instance: Foo? = sut[Foo.self]
        XCTAssertNil(instance)
    }
    
    func testSubscript_WhenRegistered_ShouldReturnInstance() throws {
        let foo = Foo()
        try sut.register(as: Foo.self, injectable: .singleton(foo))
        let instance: Foo? = sut[Foo.self]
        XCTAssertNotNil(instance)
        XCTAssert(foo === instance)
    }
    
    func testGet_WhenTypeNotRegistered_ShouldThrowError() {
        do {
            let _: PFoo = try sut.get(as: PFoo.self)
            XCTFail("Expected to throw error")
        } catch InjectorError.notRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
        
    func testRegister_WhenCalled_ShouldReturnSameInjectorInstance() throws {
        try XCTAssertTrue(sut === sut.register(as: Foo.self, injectable: .singleton(Foo())))
    }
    
    func testRegister_WhenAlreadyRegistered_ShouldThrowError() throws {
        try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
        do {
            try sut.register(as: PFoo.self, injectable: .singleton(Bar()))
            XCTFail("Expected to throw error")
        } catch InjectorError.alreadyRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
    
    func testUnregister_WhenNotRegistered_ShouldThrowError() {
        do {
            try sut.unregister(type: PFoo.self)
            XCTFail("Expected to throw error")
        } catch InjectorError.notRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
    
    func testUnregister_WhenRegistered_ShouldUnregisterService() throws {
        try sut.register(as: PFoo.self, injectable: .singleton(Foo())).unregister(type: PFoo.self)
        do {
            let _: PFoo = try sut.get(as: PFoo.self)
            XCTFail("Expected to throw error")
        } catch InjectorError.notRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
    
    func testRegister_WhenCalledAndRewriteIsNotAllowed_ShouldThrow() {
        do {
            sut = Injector(allowRewrite: false)
            try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
            try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
            XCTFail("Expected to throw error")
        } catch InjectorError.alreadyRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
    
    func testRegister_WhenCalledAndRewriteIsAllowed_ShouldNotThrow() throws {
        sut = Injector(allowRewrite: true)
        try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
        try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
    }
    
    func testRegister_WhenCalledAndRewriteIsNotAllowedButServiceWasUnregistered_ShouldNotThrow() throws {
        sut = Injector(allowRewrite: false)
        try sut.register(as: PFoo.self, injectable: .singleton(Foo())).unregister(type: PFoo.self)
        try sut.register(as: PFoo.self, injectable: .singleton(Foo()))
    }
}
