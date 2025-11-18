// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TinodeiOS",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "TinodeSDK", targets: ["TinodeSDK"])
    ],
    targets: [
        .target(
            name: "TinodeSDK",
            path: "TinodeSDK"
        ),
        .testTarget(
            name: "TinodeSDKTests",
            dependencies: ["TinodeSDK"],
            path: "TinodeSDKTests"
        )
    ]
)
