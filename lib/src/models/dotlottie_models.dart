import 'dart:typed_data';

class ManifestAnimation {
  late String id;
  double speed = 1.0;
  String? themeColor;
  bool loop = false;

  ManifestAnimation(this.id, this.speed, this.themeColor, this.loop);

  ManifestAnimation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    speed = json['speed'] ?? 1.0;
    themeColor = json['themeColor'];
    loop = json['loop'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['speed'] = speed;
    data['loop'] = loop;
    return data;
  }
}

class Manifest {
  String? generator, author;
  int? revision;
  String? version;
  late List<ManifestAnimation> animations;
  Map<String, dynamic>? custom;

  Manifest(this.generator, this.author, this.revision, this.version,
      this.animations, this.custom);

  Manifest.fromJson(Map<String, dynamic> json) {
    if (json['animations'] != null) {
      animations = <ManifestAnimation>[];
      json['animations'].forEach((v) {
        animations.add(ManifestAnimation.fromJson(v));
      });
    }
    author = json['author'];
    revision = json['revision'];
    generator = json['generator'];
    custom = json['custom'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animations'] = animations.map((v) => v.toJson()).toList();
    data['author'] = author;
    data['revision'] = revision;
    data['generator'] = generator;
    data['custom'] = custom;
    data['version'] = version;
    return data;
  }
}

class DotLottie {
  Manifest? manifest;
  Map<String, Uint8List> animations;
  Map<String, Uint8List> images;

  DotLottie(this.manifest, this.animations, this.images);
}
