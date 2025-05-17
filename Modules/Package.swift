// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CryptoExchange",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Umbrella", targets: ["Umbrella"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "CoreUI", targets: ["CoreUI"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "Scenes", targets: ["Scenes"]),
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
                "Scenes"
            ]
        ),
        .target(name: "Core"),
        .target(
            name: "CoreUI",
            dependencies: [
                "Core"
            ]
        ),
        .target(name: "Networking"),
        .target(name: "DesignSystem"),
        .target(
            name: "Scenes",
            dependencies: [
                "Core",
                "CoreUI"
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
