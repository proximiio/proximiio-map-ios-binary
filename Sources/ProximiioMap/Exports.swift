//
//  Exports.swift
//  ProximiioMap — binary distribution shim
//
//  The whole map ships as one precompiled module, `ProximiioMapBinary`. This
//  source target re-exports it so a customer writes `import ProximiioMap`, the
//  same line they write against the source package.
//
//  What is NOT re-exported here: MapLibre. That mirrors the source package's
//  own umbrella — an app that wants `MLNMapView` types in scope says
//  `import MapLibre` itself, which keeps the escape hatch a greppable act in
//  app code and keeps a future MapLibre major a breaking change to this
//  package's SemVer rather than a silent one to every consumer's namespace.
//
//  Do not add declarations to this file. The umbrella is a re-export; anything
//  with an API of its own belongs in the source package, where it is tested.
//

@_exported import ProximiioMapBinary
