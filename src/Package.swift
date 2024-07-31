// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "P3_Battle",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "P3_Battle",
            dependencies: [.product(name: "Vapor", package: "vapor")],
            path: "Sources"
        ),

    ]
)