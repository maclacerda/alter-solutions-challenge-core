// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AlterSolutionsChallengeCore",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AlterSolutionsChallengeCore",
            targets: ["AlterSolutionsChallengeCore"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AlterSolutionsChallengeCore",
            url: "https://github.com/maclacerda/MLNetwork/raw/master/binary-framework/MLNetwork.xcframework.zip",
            checksum: ""
        )
    ]
)