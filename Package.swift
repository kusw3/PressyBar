// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "PressyBar",
    platforms: [.macOS(.v11)],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "PressyBar",
            dependencies: [],
            linkerSettings: [
                .linkedFramework("AppKit"),
                .linkedFramework("CoreGraphics")
            ]
        )
    ]
)
