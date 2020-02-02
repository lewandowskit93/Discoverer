// swift-tools-version:5.1
//
//  Package.swift
//  Discoverer
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//
import PackageDescription

let package = Package(
    name: "Discoverer",
    products: [
        .library(
            name: "Discoverer",
            targets: ["Discoverer"])
    ],
    targets: [
        .target(
            name: "Discoverer",
            dependencies: [],
            path: "Discoverer"),
        .testTarget(
            name: "DiscovererTests",
            dependencies: ["Discoverer"],
            path: "DiscovererTests")
    ]
)
