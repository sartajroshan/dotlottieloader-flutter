
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
DotLottieLoader.fromAsset("assets/animation_external_image.lottie",
frameBuilder: (ctx, dotlottie) {
if (dotlottie != null) {
return Lottie.memory(dotlottie.animations.values.single,
imageProviderFactory: (asset) {
return MemoryImage(dotlottie.images[asset.fileName]!);
}
);
} else {
return Container();
}
})
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

## View documentation, FAQ, help, examples, and more at [dotlottie.io](http://dotlottie.io/)
