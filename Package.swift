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
            url: "https://github.com/maclacerda/alter-solutions-challenge-core/raw/main/binary-framework/alter-solutions-challenge-core.xcframework.zip",
            checksum: "18f48537e5d534dc19960d3bdd48297f6c069950a11694d22cbc9bb182be412e"
        )
    ]
)
