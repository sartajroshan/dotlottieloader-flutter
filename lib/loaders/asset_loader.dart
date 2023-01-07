import 'package:dotlottie_loader/dotlottie_converter.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:dotlottie_loader/loaders/abstarct_loader.dart';
import 'package:dotlottie_loader/models/dotlottie_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AssetLoader extends AbstractLoader {
  final String assetName;

  String get keyName =>
      package == null ? assetName : 'packages/$package/$assetName';

  final AssetBundle? bundle;

  final String? package;

  AssetLoader(this.assetName, {this.bundle, this.package});

  @override
  Future<DotLottie> load() {
    return sharedLottieCache.putIfAbsent(this, () async {
      final chosenBundle = bundle ?? rootBundle;

      var data = await chosenBundle.load(keyName);

      return await DotLottieConverter.fromByteData(data, name: keyName);
    });
  }


  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    return other is AssetLoader &&
        other.keyName == keyName &&
        other.bundle == bundle;
  }

  @override
  int get hashCode => Object.hash(keyName, bundle);

  @override
  String toString() => '$runtimeType(bundle: $bundle, name: "$keyName")';
}
