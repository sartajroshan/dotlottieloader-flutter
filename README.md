> [!WARNING]
> **Maintenance mode / deprecated for new projects**
>
> This package is now in **maintenance mode** and is **not recommended for new projects**.
> If you're starting a new Flutter app, please use the official
> [`dotlottie-flutter`](https://github.com/LottieFiles/dotlottie-flutter) package maintained by the LottieFiles team.
>
> `dotlottie_loader` will continue to receive critical fixes for existing users, but no major new features are planned.

A lightweight Flutter package to load and extract `.lottie` files.

---

## Why this notice?

`dotlottie_loader` was originally created as a lightweight way to load and extract `.lottie` files in Flutter.

Today, the official LottieFiles team maintains
[`dotlottie-flutter`](https://github.com/LottieFiles/dotlottie-flutter), which is the better long-term choice for most new projects.

This package remains available for existing users who already depend on its current workflow.

---

## Should I still use this package?

You may continue using `dotlottie_loader` if:

- your app already depends on it
- you prefer its current loader-style workflow
- you need a lightweight helper around `.lottie` extraction
- migrating right now is not convenient

For **new projects**, we strongly recommend using the official package instead.

---

## Migration to `dotlottie-flutter`

If you're starting fresh, use the official package:
[`dotlottie-flutter`](https://github.com/LottieFiles/dotlottie-flutter)

Basic migration steps:

1. Remove `dotlottie_loader` from `pubspec.yaml`
2. Add the official `dotlottie-flutter` package
3. Replace `DotLottieLoader(...)` usage with the official widget/API
4. Test asset loading, network loading, and animation playback in your app
5. Verify behavior on Android, iOS, and Web if applicable

> Note: `dotlottie_loader` and `dotlottie-flutter` do not expose the same API, so small code changes may be required during migration.

A fuller migration guide may be added later.

---

# dotLottieLoader for Flutter

[![pub package](https://img.shields.io/pub/v/dotlottie_loader.svg)](https://pub.dev/packages/dotlottie_loader)

dotLottieLoader is a library to help downloading and deflating a .lottie file, giving access to the animation,
as well as the assets included in the bundle. This repository is an unofficial conversion of the [dotottieloader-android](https://github.com/dotlottie/dotlottieloader-android) library in pure Dart. 

It works on Android, iOS, macOS, linux, windows and web.

## Install

```
flutter pub add dotlottie_loader
```

Also install [lottie](https://pub.dev/packages/lottie) package to render the animations.

## Usage

#### loading from app assets

```dart
 DotLottieLoader.fromAsset("assets/anim2.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
```

#### loading from network

```dart
 DotLottieLoader.fromNetwork(
                "https://github.com/sartajroshan/dotlottieloader-flutter/raw/master/example/assets/animation.lottie",
                frameBuilder: (ctx, dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie!.animations.values.single);
                  } else {
                    return Container();
                  }
                },
                errorBuilder: (ctx, e, s) {
                  print(s);
                  return Text(e.toString());
                },
              ),
```

#### loading with images

```dart
 DotLottieLoader.fromAsset(
          "assets/animation_external_image.lottie",
          frameBuilder: (ctx, dotlottie) {
            if (dotlottie != null) {
                return Lottie.memory(dotlottie.animations.values.single,
                        imageProviderFactory: (asset) {
                          return MemoryImage(dotlottie.images[asset.fileName]!);
                        },
                      );
            } else {
              return Container();
            }
          },
 )
```


#### DotLottie data

```dart
class ManifestAnimation {
   String id;
  double speed;
  String? themeColor;
  bool loop;

  ManifestAnimation(this.id, this.speed, this.themeColor, this.loop);
}

class Manifest {
  String? generator, author;
  int? revision;
  String? version;
  late List<ManifestAnimation> animations;
  Map<String, dynamic>? custom;

  Manifest(this.generator, this.author, this.revision, this.version,
      this.animations, this.custom);
}

class DotLottie {
  Manifest? manifest;
  Map<String, Uint8List> animations;
  Map<String, Uint8List> images;

  DotLottie(this.manifest, this.animations, this.images);
}
```

## View documentation, FAQ, help, examples, and more at [dotlottie.io](https://dotlottie.io/)
