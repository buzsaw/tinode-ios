// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TinodeiOS",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13) // bump to v14+ if you need newer APIs
    ],
    products: [
        // This is the only public product users will add to their apps.
        .library(name: "TinodeSDK", targets: ["TinodeSDK"])
    ],
    dependencies: [
        // Keep empty unless the *SDK itself* needs external packages.
        // App-level deps like Firebase, WebRTC, MobileVLCKit, etc. stay in the app,
        // not in the SDK package.
    ],
    targets: [
        .target(
            name: "TinodeSDK",
            path: "TinodeSDK",
            exclude: [
                // Add any non-source items in this folder you don’t want compiled.
                // Examples (uncomment if present):
                // "Info.plist"
            ],
            resources: [
                // Declare resources if the SDK ships bundles/strings/images.
                // .process("Resources")
            ],
            swiftSettings: [
                // Enable stricter warnings if you like:
                // .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "TinodeSDKTests",
            dependencies: ["TinodeSDK"],
            path: "TinodeSDKTests"
        )
    ]
)
