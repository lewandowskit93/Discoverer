// swift-tools-version:5.1
//
//  Package.swift
//  Injector
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//
import PackageDescription

let package = Package(
    name: "Injector",
    products: [
        .library(
            name: "Injector",
            targets: ["Injector"])
    ],
    targets: [
        .target(
            name: "Injector",
            dependencies: [],
            path: "Injector"),
        .testTarget(
            name: "InjectorTests",
            dependencies: ["Injector"],
            path: "InjectorTests")
    ]
)
