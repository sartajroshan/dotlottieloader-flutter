import 'package:dotlottie_loader/dotlottie_converter.dart';
import 'package:dotlottie_loader/loaders/abstarct_loader.dart';
import 'package:dotlottie_loader/models/dotlottie_models.dart';
import 'package:dotlottie_loader/util.dart';
import 'loader_io.dart' if (dart.library.html) 'loader_web.dart' as io;

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
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FileLoader && other.file == file;
  }

  @override
  int get hashCode => file.hashCode;

  @override
  String toString() => '$runtimeType(file: ${io.filePath(file)})';
}
