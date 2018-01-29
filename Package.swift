// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SwiftDotEnv",
    dependencies: [],
    targets: [
        .target(
            name: "DotEnv",
            dependencies: []
        ),
        .testTarget(
            name: "DotEnvTests",
            dependencies: ["DotEnv"]
        )
    ]
)
