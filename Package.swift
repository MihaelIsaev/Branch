// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Branch",
    products: [
        .library(
            name: "Branch",
            targets: ["Branch"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Branch",
            dependencies: ["Vapor"]),
        .testTarget(
            name: "BranchTests",
            dependencies: ["Branch"]),
    ]
)
