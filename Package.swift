// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CommonFeatures",
  platforms: [.macOS(.v14),],
  
  products: [
    .library(name: "SettingsModel", targets: ["SettingsModel"]),
    .library(name: "SharedModel", targets: ["SharedModel"]),
  ],

  dependencies: [
    // ----- OTHER -----
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.0.0"),
  ],
  
  // --------------- Modules ---------------
  targets: [
    // SettingsModel
    .target(name: "SettingsModel", dependencies: [
      .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
      "SharedModel",
    ]),

    // SharedModel
    .target(name: "SharedModel", dependencies: [
      .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
    ]),
  ]
  
  // --------------- Tests ---------------
)
