// swift-tools-version:6.0
// Proximi.io iOS map — BINARY distribution package.
//
// This file is regenerated per release by scripts/publish-binary-release.sh;
// the __PLACEHOLDER__ tokens below are rewritten to the published release asset
// URL, its checksum, and the two versions this build was compiled against. Do
// not hand-edit the binaryTarget block or the two `exact:` requirements — they
// are rendered from manifest.json, which build-map-xcframework.sh wrote from
// the versions the binary actually links.
import PackageDescription

let package = Package(
    name: "ProximiioMap",
    platforms: [
        // iOS only. The source package also declares macOS so the
        // platform-neutral half can `swift test` on a dev machine; there is
        // nothing to declare here, because MapLibre ships an iOS-only
        // xcframework and every module in this binary is behind it.
        .iOS(.v15),
    ],
    products: [
        // ─────────────────────────────────────────────────────────────────
        // ONE PRODUCT, AND WHY THE SOURCE PACKAGE'S OTHER TWO ARE NOT HERE.
        //
        // The source package vends three: `ProximiioMap` (umbrella),
        // `ProximiioMapKit` (canvas + renderers, does NOT link the
        // positioning stack) and `ProximiioMapCore` (pure values, links
        // neither MapLibre nor UIKit). Only the umbrella is vended here.
        //
        // `ProximiioMapKit` and `ProximiioMapCore` exist in source for exactly
        // one customer-visible reason: what they keep OUT of the link graph.
        // A binary distribution cannot keep that promise:
        //
        //   1. This artefact is ONE flattened module. A `ProximiioMapKit`
        //      product here would be one line of `@_exported import
        //      ProximiioMapBinary` — the same bytes, the same link, the whole
        //      surface. It would buy the name and contradict the documentation
        //      that gives the name its meaning.
        //
        //   2. The promise is already gone one level down, before this package
        //      does anything. `ProximiioMapCore` depends on the SDK's
        //      `ProximiioCore`, and in the BINARY SDK `ProximiioCore` is itself
        //      a one-line shim over the flattened `ProximiioBinary`. Anything
        //      that reaches the map's Core in binary form links the entire
        //      positioning SDK regardless of what this manifest says.
        //
        // So a shim here would be a name whose own README calls it a boundary,
        // over bytes that have no boundary in them. A customer who genuinely
        // needs the canvas without the positioning stack wants the SOURCE
        // package, where the split is real. See docs/RELEASING.md, "Products".
        // ─────────────────────────────────────────────────────────────────
        .library(name: "ProximiioMap", targets: ["ProximiioMap"]),
    ],
    dependencies: [
        // ── MapLibre ─────────────────────────────────────────────────────
        // `exact:`, and it must appear EXACTLY ONCE in a consumer's whole
        // graph. `MapLibre` is a SwiftPM binaryTarget, and SwiftPM cannot
        // deduplicate two binary targets vending the same product name: a
        // graph reaching MapLibre twice at two versions is a hard resolution
        // failure, not a warning.
        //
        // This is the same single declaration the source package carries, and
        // the two are rendered from the same number. The support window in the
        // map README is the policy this line implements: ONE MapLibre version
        // per ProximiioMap tag, no compatibility range, old pins supported by
        // the tag that carries them. If you already link MapLibre, match this.
        .package(
            url: "https://github.com/maplibre/maplibre-gl-native-distribution",
            exact: "6.29.0"
        ),
        // ── The Proximi.io SDK, PUBLIC BINARY distribution ───────────────
        // Never the private source package (proximiio-ios-sdk-v6). Two
        // packages vending a product named `Proximiio` is a hard resolution
        // failure, and avoiding it is the entire reason the public/private
        // split exists. See docs/public-distribution.md.
        //
        // `exact:`, not `upToNextMinor:`. The SDK binary IS built with
        // BUILD_LIBRARY_FOR_DISTRIBUTION=YES and ships only a textual
        // `.swiftinterface`, so module stability is real — but module
        // stability is a property of the FORMAT, not a promise about the API,
        // and the SDK is `6.0.0-beta.x`, where a beta bump is explicitly free
        // to move public API. SwiftPM range semantics make that worse, not
        // better: `upToNextMinor(from: "6.0.0-beta.33")` admits every later
        // 6.0.0 prerelease, which is precisely the set of versions with no
        // compatibility promise attached.
        //
        // There is a harder reason than policy. This artefact's shipped
        // `.swiftinterface` names types by their DEFINING module —
        // `ProximiioBinary.<T>` — and a consumer's compiler rebuilds that text
        // against whatever SDK the graph resolved. A renamed or removed type
        // in a later beta is not a deprecation warning here, it is a consumer
        // whose build cannot reconstruct this module at all. `exact:` is the only
        // requirement that guarantees the graph contains the bytes this binary
        // was compiled against.
        //
        // Cost, stated plainly: an app that also depends on the binary SDK
        // directly is bound to THIS SDK version, and every SDK release the map
        // should track needs a map re-tag. Revisit at SDK GA — see
        // docs/RELEASING.md, "How the map's version relates to the SDK's".
        .package(
            url: "https://github.com/proximiio/proximiio-sdk-ios-binary",
            exact: "6.0.0-beta.33"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "ProximiioMapBinary",
            url: "https://github.com/proximiio/proximiio-map-ios-binary/releases/download/6.0.0-beta.2/ProximiioMapBinary.xcframework.zip",
            checksum: "b1248afa95f03c12a9b56b2cf8e8b24f44023b1173170f25eee5157468a4265c"
        ),
        // ── the source shim ──────────────────────────────────────────────
        // One line of `@_exported import ProximiioMapBinary`, so customers
        // write `import ProximiioMap` exactly as they do against source.
        //
        // READ THIS BEFORE CHANGING THE DEPENDENCY LIST. Every module named by
        // an `import` line in the shipped `.swiftinterface` must be reachable
        // from THIS target, because the customer's compiler rebuilds that
        // textual interface and needs each one on its search path. The
        // interface prints every non-implementation-only import as written.
        //
        // That is not a theoretical rule. The SDK shipped an interface
        // containing `import GRDB` and became unconsumable via the SwiftPM CLI
        // with `missing required module 'GRDBSQLite'`, because `-Xcc` flags do
        // not reach the interface-rebuild sub-invocation. Here the interface
        // imports MapLibre, Proximiio and ProximiioCore, and all three are
        // listed below on purpose:
        //
        //   MapLibre       — a binary framework. Reached via a Swift framework
        //                    search path (`-F`), which IS inherited by the
        //                    interface-rebuild sub-invocation, unlike `-Xcc`.
        //                    This is why MapLibre is not a second GRDBSQLite.
        //   Proximiio      — the SDK umbrella; the map's live binding imports it.
        //   ProximiioCore  — the map's Core imports it directly. Dropping it
        //                    here because "Proximiio re-exports it anyway"
        //                    breaks the interface rebuild: the customer's
        //                    compiler must resolve the module NAMED on the
        //                    import line, not an equivalent surface.
        //
        // scripts/build-map-xcframework.sh records the interface's imports in
        // manifest.json and scripts/verify-binary-release.sh asserts every one
        // of them is declared here. Adding an import to the map's sources
        // without adding it here fails our gate rather than a customer's build.
        .target(
            name: "ProximiioMap",
            dependencies: [
                "ProximiioMapBinary",
                .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),
                .product(name: "Proximiio", package: "proximiio-sdk-ios-binary"),
                .product(name: "ProximiioCore", package: "proximiio-sdk-ios-binary"),
            ]
        ),
    ]
)
