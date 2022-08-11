// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Wing",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Wing",
            targets: ["Wing"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/SwiftUIX/SwiftUIX.git", branch: "master"),
         .package(url: "https://github.com/CoderMJLee/MJRefresh.git", branch: "master"),
         .package(url: "https://github.com/SwiftKickMobile/SwiftMessages.git", branch: "master"),
         .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", branch: "master"),
         .package(url: "https://github.com/apple/swift-algorithms.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Wing",
            dependencies: ["SwiftUIX",
                          "MJRefresh",
                          "SwiftMessages",
                           .product(name: "Introspect", package: "SwiftUI-Introspect"),
                           .product(name: "Algorithms", package: "swift-algorithms")]),
        .testTarget(
            name: "WingTests",
            dependencies: ["Wing"]),
    ]
)
