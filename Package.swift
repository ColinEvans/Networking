// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
      .package(url: "https://github.com/WeTransfer/Mocker.git", branch: "master")
    ],
    targets: [
        .target(
            name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking", "Mocker"]),
    ]
)
