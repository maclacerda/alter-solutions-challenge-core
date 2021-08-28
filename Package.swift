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
            checksum: "06b1b7f294ec1d3e09fb2f84944cfcb5541c6a13302158c7cd40b868608ebb8a"
        )
    ]
)
