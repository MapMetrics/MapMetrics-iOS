// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MapMetrics",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "MapMetrics",
            targets: ["MapMetrics"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MapMetrics",
            path: "./MapMetrics.xcframework"
        )
    ]
)
