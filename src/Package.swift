// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "P3_Battle",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "P3_Battle",
            dependencies: []),
        .testTarget(
            name: "P3_BattleTests",
            dependencies: ["P3_Battle"]),
    ]
)