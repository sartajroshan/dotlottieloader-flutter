import 'package:dotlottie_loader/src/util.dart';

import '../dotlottie_converter.dart';
import '../models/dotlottie_models.dart';
import 'abstarct_loader.dart';
import 'loader_io.dart' if (dart.library.js_interop) 'loader_web.dart' as io;

/// Concrete [AbstractLoader] that loads a File
class FileLoader extends AbstractLoader {
  final Object file;

  String get keyName => io.filePath(file).lastSegmentName();

  FileLoader(this.file);

  @override
  Future<DotLottie> load() {
    return sharedLottieCache.putIfAbsent(this, () async {
      var bytes = await io.loadFile(file);
      return await DotLottieConverter.fromBytes(bytes, name: keyName);
    });
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FileLoader && other.file == file;
  }

  @override
  int get hashCode => file.hashCode;

  @override
  String toString() => '$runtimeType(file: ${io.filePath(file)})';
}
