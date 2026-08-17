# Changelog

## 1.0.0

Rebuilt on MapLibre Native **6.28.0** (previously 6.12.1, February 2025).

### Breaking / behavioural

- **The renderer is now Metal, not OpenGL ES.** The binary links `Metal` and
  `MetalKit`; it no longer links `OpenGLES` or `GLKit`. The podspec's declared
  frameworks were updated to match. Apps that assumed an OpenGL ES context
  underneath the map will need to be re-checked.
- **Map endpoints are no longer compiled into the SDK.** A previous revision
  hardcoded an access token and two style URLs in `MLNMapView`. Supply your own
  configuration instead, either by passing a `styleURL` directly or via
  `Info.plist` — see the Configuration section of the README.

### Fixed

- `EXCLUDED_ARCHS[sdk=iphonesimulator*] = arm64` has been removed from the
  podspec. The simulator slice has always contained both `x86_64` and `arm64`,
  so this setting only prevented Apple Silicon Macs from building for the
  simulator.
- The distributed framework no longer contains a leaked `bazel-out/` build tree.
- Bundle version metadata is now stamped correctly. Earlier releases shipped the
  placeholder `1.2.3456789`, which indicated they were built by hand rather than
  through the release workflow. This release reports `6.28.0`.
- The snapshotter logo asset (`mapmetrics-logo-icon`) contained MapLibre's
  artwork; both logo asset slots now resolve to the MapMetrics logo.
- The logo's VoiceOver label announced "Mapbox" (and "맵박스" in Korean). It now
  announces "MapMetrics" in all 22 localizations.
- `exclude_files` no longer strips the SDK's 24 localization bundles.
- README now references an installable version. `0.0.2` was published to
  CocoaPods but its git tag was never pushed, so pinning that exact version
  failed to resolve.

### Improved

- Framework size reduced from **134 MB to 49 MB** (optimised release build).
- **dSYMs are now produced** for both the device and simulator slices, so crash
  reports can be symbolicated. Previous releases shipped none.
- 87 public headers, up from 78, reflecting new upstream API.
- Includes 16 releases of upstream fixes, among them: a blurry map view in
  landscape on iPad, an iOS 26 Smart Display Zoom layout feedback loop affecting
  CarPlay, two pure-virtual-call crashes, a use-after-free in `ImageManager`,
  and `MLNScaleBar` not being exported.

### Known issues

- The logo is white-filled with a thin grey stroke. Measured against the
  production light style, the fill sits at a **1.06:1** contrast ratio with the
  basemap (WCAG AA wants 3.0:1 for large text). It still reads, but only because
  of the stroke, so legibility is fragile over busy or light map features.
  Artwork filled `#000` at 40% opacity on a `#fff` halo — the approach upstream
  uses — would work on both light and dark basemaps.

## 0.0.3 and earlier

Built on MapLibre Native 6.12.1. See the git history.
