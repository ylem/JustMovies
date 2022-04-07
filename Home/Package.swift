// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: "Assets", path: "../Assets"),
        .package(name: "Networking", path: "../Networking"),
        .package(name: "Models", path: "../Models"),
        .package(name: "Navigation", path: "../Navigation"),
        .package(name: "Storage", path: "../Storage"),
        .package(name: "CommonUI", path: "../CommonUI"),
        .package(name: "SwiftRedux", path: "../SwiftRedux"),

        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Home",
            dependencies: [
                "Assets",
                "Models",
                "Networking",
                "Navigation",
                "SwiftRedux",
                "Storage",
                "CommonUI",
            ]),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "Models",
                "Storage",
                "Networking",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            exclude: [
                "__Snapshots__"
            ],
            resources: [
                .copy("Arranges/popular-movie-success.json"),
                .copy("Arranges/popular-tv-success.json"),
            ]
        ),
    ]
)
