# Disk Inventory X (Apple Silicon Fork)

[![Build](https://github.com/diulama/disk-inventory-x/actions/workflows/build.yml/badge.svg)](https://github.com/diulama/disk-inventory-x/actions/workflows/build.yml)
![License](https://img.shields.io/badge/license-GPL--3.0-blue)
![Platform](https://img.shields.io/badge/macOS-11%2B-lightgrey)

A macOS disk usage visualizer using treemaps. This fork adds Apple Silicon (arm64) and modern macOS support.

Original project by Tjark Derlien: https://gitlab.com/tderlien/disk-inventory-x

Apple Silicon port by Keita Ikeda: https://github.com/KeitaIkeda/disk-inventory-x

## Changes from upstream

- Universal Binary (arm64 + x86_64), minimum deployment target macOS 11 (Big Sur)
- Removed OmniFrameworks (OmniBase, OmniFoundation, OmniAppKit) and Carbon dependencies
- Deprecated LaunchServices / UTI / AppKit APIs replaced with their modern
  equivalents (`UniformTypeIdentifiers`, `NSWorkspace` URL APIs, block-based `NSAlert` sheets, …)
- Builds for anyone out of the box: ad-hoc signing, no hardcoded development team
- GitHub Actions CI for every pull request, plus tag-driven release builds
- Tested on macOS Tahoe (26) with Apple Silicon

## Download

This fork doesn't publish prebuilt binaries. To get the app, build it from source (see [Building](#building)), or download the unsigned `Disk-Inventory-X-unsigned` artifact from a successful [Build workflow](https://github.com/diulama/disk-inventory-x/actions/workflows/build.yml) run.

> **Note:** The app isn't signed with an Apple Developer ID, so macOS blocks a downloaded copy on first launch. To open it:
> 1. Right-click the app → **Open** → **Open** in the dialog
> 2. Or: **System Settings → Privacy & Security → Open Anyway**
> 3. Or run: `xattr -cr "Disk Inventory X.app"`

## Building

Requirements: Xcode 16 or later (CI builds with Xcode 16 on macOS 15).

```sh
# Open in Xcode and press ⌘R
open "Disk Inventory X.xcodeproj"

# …or build a universal, zipped Release from the command line
scripts/build-release.sh            # → build/release/Disk-Inventory-X-<version>.zip
```

To sign with your own certificate, pass `CODE_SIGN_IDENTITY` and `DEVELOPMENT_TEAM`
as environment variables to `scripts/build-release.sh`, or set your team in Xcode's
*Signing & Capabilities* tab (don't commit it).

`TreeMapView.framework` (Universal Binary) is vendored in `Frameworks/`.
To rebuild it from source, see [treemapview-framework](https://github.com/KeitaIkeda/treemapview-framework).

## Project layout

```
Sources/
  App/                 app & document controllers, FSItem model, main.m, prefix header
  TreeMap/             treemap view controller
  FilesOutline/        file outline view
  FileKinds/           file-kind statistics table
  SelectionList/       selection list & kind popup
  InfoPanel/           Get Info panel
  DrivesPanel/         volume chooser
  Preferences/         preference panes
  Helpers/             formatters, value transformers, timing
  AppKitExtensions/    NSTableView/NSOutlineView/NSCell subclasses, toolbar controller
  FoundationExtensions/ NSURL / NSFileManager categories
  CocoaTech/           vendored legacy CocoaTech info view & pasteboard helpers
Resources/             Info.plist, entitlements, asset catalog, images, *.lproj localizations
Frameworks/            prebuilt TreeMapView.framework
docs/                  developer notes, known bugs, release notes
scripts/               build & packaging scripts
```

## Releasing

Push a tag like `v1.4.0`. The [Release workflow](.github/workflows/release.yml) builds a universal
app with `scripts/build-release.sh` and attaches the zip to a draft GitHub release.

## License

GPL-3.0. See [COPYING](COPYING).

## Authors

- Tjark Derlien: original author
- Keita Ikeda: Apple Silicon port, Omni framework removal, and static-review fixes
