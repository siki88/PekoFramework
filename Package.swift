// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PekoFramework",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PekoFramework",
            targets: ["PekoFramework"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tadelv/Wormholy", .upToNextMajor(from: "1.6.5")),
        .package(url: "https://github.com/SwifterSwift/SwifterSwift", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/malcommac/SwiftDate", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        .target(
            name: "PekoFramework",
            dependencies: ["Wormholy", "SwifterSwift", "SwiftDate"]
        )
    ]
)


 // TUDU
 // DELAJI NA FIXECH PRO IMPLEMENTACI PRES SPM, momentalne nainstalovany alternativni/tadelv
 
 //Womholy.awake()
 //https://github.com/pmusolino/Wormholy
 
 //neoriginalni alternativni clone:
 //https://github.com/tadelv/Wormholy
 //před použitím zavoláte Womholy.awake()
