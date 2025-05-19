// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CryptoExchange",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "Umbrella", targets: ["Umbrella"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "CoreUI", targets: ["CoreUI"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "Scenes", targets: ["Scenes"]),
        .library(name: "Models", targets: ["Models"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Umbrella",
            dependencies: [
                "Core",
                "CoreUI",
                "Networking",
                "DesignSystem",
                "Scenes",
                "Models",
            ]
        ),
        .target(name: "Core"),
        .target(
            name: "CoreUI",
            dependencies: [
                "Core",
            ]
        ),
        .target(name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
        .target(
            name: "DesignSystem",
            dependencies: [
                "CoreUI",
            ]
        ),
        .target(
            name: "Scenes",
            dependencies: [
                "Core",
                "CoreUI",
                "DesignSystem",
                "Models",
                "Networking",
            ]
        ),
        .target(
            name: "Models"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
