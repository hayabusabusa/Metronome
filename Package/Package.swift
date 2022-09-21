// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "MetronomeFeature"
            ]),
        .target(
            name: "Audio",
            dependencies: [],
            resources: [
                .copy("Resource/click.mp3")
            ]),
        .target(
            name: "MetronomeFeature",
            dependencies: [
                "Audio"
            ]
        ),
        .testTarget(
            name: "PackageTests",
            dependencies: [
                "AppFeature"
            ]),
    ]
)
