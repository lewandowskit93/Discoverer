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
        try sut.register(as: Foo.self, singleton: foo)
        let _: Foo = try sut.get()
    }
    
    func testGet_WhenRegisteredWithProtocolSingleton_ShouldReturnInstance() throws {
        let foo = Foo()
        try sut.register(as: PFoo.self, singleton: foo)
        let _: PFoo = try sut.get()
    }
    
    func testGet_WhenTypeNotRegistered_ShouldThrowError() {
        do {
            let _: PFoo = try sut.get()
            XCTFail("Expected to throw error")
        } catch InjectorError.notRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
    
    func testRegister_WhenCalled_ShouldReturnSameInjectorInstance() throws {
        try XCTAssertTrue(sut === sut.register(as: Foo.self, singleton: Foo()))
    }
    
    func testRegister_WhenAlreadyRegistered_ShouldThrowError() throws {
        try sut.register(as: PFoo.self, singleton: Foo())
        do {
            try sut.register(as: PFoo.self, singleton: Bar())
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
        try sut.register(as: PFoo.self, singleton: Foo()).unregister(type: PFoo.self)
        do {
            let _: PFoo = try sut.get()
            XCTFail("Expected to throw error")
        } catch InjectorError.notRegistered {
            // nothing to do
        } catch {
            XCTFail("Invalid error thrown")
        }
    }
}
