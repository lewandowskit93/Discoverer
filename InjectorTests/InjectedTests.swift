//
//  InjectedTests.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 02/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import XCTest
@testable import Injector

final class InjectedTests: XCTestCase {
    func testInjectedAttribute() throws {
        struct SUT {
            static let injector = Injector()
            @Injected(injector: injector) var foo: Foo
        }
        let instance = Foo()
        try SUT.injector.register(as: Foo.self, injection: .singleton(instance))
        let sut = SUT()
        XCTAssertTrue(sut.foo === instance)
    }
}
