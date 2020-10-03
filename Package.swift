// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dropdown",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Dropdown",
            targets: ["Dropdown"]),
    ],
    targets: [
        .target(
            name: "Dropdown",
            path: "Dropdown"
        )
    ]
)
