// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationsFeature",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NotificationsFeature",
            targets: ["NotificationsFeature"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "ApplicationLayer", path: "../ApplicationLayer"),
        .package(name: "NetworkLayer", path: "../NetworkLayer"),
        .package(name: "UILayer", path: "../UILayer"),
        .package(url: "https://github.com/hmlongco/Resolver.git", exact: "1.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NotificationsFeature",
            dependencies: ["ApplicationLayer", "NetworkLayer", "UILayer", "Resolver"]),
        .testTarget(
            name: "NotificationsFeatureTests",
            dependencies: ["NotificationsFeature"]),
    ]
)

