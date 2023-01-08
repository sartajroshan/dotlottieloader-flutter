<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

### dotLottieLoader for Flutter

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
