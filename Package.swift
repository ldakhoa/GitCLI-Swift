// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-gitcli",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "gitswift", targets: ["GitSwift"]),
        .library(name: "GitSwiftCore", targets: ["GitSwiftCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "GitSwift",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "GitSwiftCLI"
            ]
        ),
        
        .target(
            name: "GitSwiftCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "GitSwiftCore"
            ]
        ),
        .testTarget(
            name: "CLITests",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "GitSwiftCLI",
            ]
        ),
        
        .target(
            name: "GitSwiftCore",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "GitSwiftCoreTests",
            dependencies: ["GitSwiftCore"]
        ),
    ]
)
