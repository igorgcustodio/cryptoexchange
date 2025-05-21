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

        // MARK: - Umbrella

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

        // MARK: - Core

        .target(name: "Core"),

        // MARK: - CoreUI

        .target(
            name: "CoreUI",
            dependencies: [
                "Core",
            ]
        ),

        // MARK: - Networking

        .target(name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),

        // MARK: - Design System

        .target(
            name: "DesignSystem",
            dependencies: [
                "CoreUI",
            ]
        ),

        // MARK: - Scenes

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

        // MARK: - Models

        .target(
            name: "Models"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
