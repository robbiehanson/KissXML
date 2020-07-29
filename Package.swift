// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "KissXML",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "KissXML",
            targets: ["KissXML"]
        )
    ],
    targets: [
        .target(
            name: "KissXML",
            path: "KissXML",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Additions"),
                .headerSearchPath("Categories"),
                .headerSearchPath("Private")
            ]
        ),
        .testTarget(
            name: "KissXMLTests",
            dependencies: ["KissXML"],
            path: "Tests/Shared",
            sources: [
                "KissXMLAssertionTests.m",
                "KissXMLTests.m"
            ]
        ),
        .testTarget(
            name: "KissXMLSwiftTests",
            dependencies: ["KissXML"],
            path: "Tests/Shared",
            sources: [
                "KissXMLSwiftTests.swift"
            ]
        )
    ]
)
