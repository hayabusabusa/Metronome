// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AppFeature",
            targets: [
                "AppFeature"
            ]),
        .library(
            name: "Preview",
            targets: [
                "Preview"
            ]),
    ],
    dependencies: [],
    targets: [
        // MARK: Feature modules

        .target(
            name: "AppFeature",
            dependencies: [
                "MetronomeFeature"
            ]),
        .target(
            name: "MetronomeFeature",
            dependencies: [
                "Audio"
            ]),

        // MARK: Internal modules

        .target(
            name: "Audio",
            dependencies: [],
            resources: [
                .copy("Resource/click.mp3")
            ]),
        .target(
            name: "Preview",
            dependencies: [
                "MetronomeFeature"
            ]),

        // MARK: Tests

        .testTarget(
            name: "PackageTests",
            dependencies: [
                "AppFeature"
            ]),
    ]
)
