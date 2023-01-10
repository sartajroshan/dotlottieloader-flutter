import '../dotlottie_converter.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import '../loaders/abstarct_loader.dart';
import '../models/dotlottie_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MemoryLoader extends AbstractLoader {
  final Uint8List bytes;

  MemoryLoader(this.bytes);

  @override
  Future<DotLottie> load() {
    return sharedLottieCache.putIfAbsent(this, () async {

      return await DotLottieConverter.fromBytes(bytes);
    });
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    return other is MemoryLoader && other.bytes == bytes;
  }

  @override
  int get hashCode => bytes.hashCode;

  @override
  String toString() => '$runtimeType(bytes: ${bytes.length})';
}
