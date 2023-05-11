// swift-tools-version:5.6
import PackageDescription
let package = Package(
    name: "TokamakApp",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "TokamakApp", targets: ["TokamakApp"])
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
    ],
    targets: [
        .executableTarget(
            name: "TokamakApp",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak")
            ],
            resources: [
                .copy("images/0.png"),
                .copy("images/1.png"),
                .copy("images/2.png"),
                .copy("images/3.png"),
                .copy("images/4.png"),
                .copy("images/5.png"),
                .copy("images/6.png"),
                .copy("images/7.png"),
                .copy("images/8.png")
                
            ]),
            
        .testTarget(
            name: "TokamakAppTests",
            dependencies: ["TokamakApp"]),
    ]
)