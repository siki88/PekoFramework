// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PekoFramework",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PekoFramework",
            targets: ["PekoFramework"]),
    ],
    //dependencies: [
    //    .package(url: "https://github.com/tadelv/Wormholy", .branch("master"))
    //],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PekoFramework")
    ]
)

/*
 import PackageDescription

 let package = Package(
     name: "PopupView",
     platforms: [
         .iOS(.v14),
         .macOS(.v11),
         .tvOS(.v14),
         .watchOS(.v7)
     ],
     products: [
         .library(
             name: "PopupView",
             targets: ["PopupView"]
         )
     ],
     dependencies: [
         .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.0.0")
     ],
     targets: [
         .target(name: "PopupView", dependencies: [
             .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
         ], path: "Source")
     ]
 )
 
 // TUDU
 // DELAJI NA FIXECH PRO IMPLEMENTACI PRES SPM
 
 //Womholy.awake()
 //https://github.com/pmusolino/Wormholy
 
 //neoriginalni alternativni clone:
 //https://github.com/tadelv/Wormholy
 //před použitím zavoláte Womholy.awake()
 */
