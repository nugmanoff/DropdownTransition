// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DropdownTransition",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "DropdownTransition",
            targets: ["DropdownTransition"]),
    ],
    targets: [
        .target(
            name: "DropdownTransition",
            path: "DropdownTransition"
        )
    ]
)
