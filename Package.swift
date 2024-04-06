// swift-tools-version: 5.10.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QulertsNotificationExtension",
    platforms: [
        .iOS(.v12), .watchOS(.v4), .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "QulertsNotificationExtension",
            targets: ["QulertsNotificationExtension"]),
    ],
    targets: [
        .target(
            name: "QulertsNotificationExtension",
            dependencies: [],
            linkerSettings: [
                    .linkedFramework("UserNotifications")
            ]
        ),
        .testTarget(
            name: "QulertsNotificationExtensionTests",
            dependencies: ["QulertsNotificationExtension"]),
    ]
)
