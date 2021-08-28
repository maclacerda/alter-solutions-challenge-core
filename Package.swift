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
        .target(
            name: "AlterSolutionsChallengeCore",
            path: "AlterSolutionsChallengeCore"
        )
    ]
)
