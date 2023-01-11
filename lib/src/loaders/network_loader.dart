import '../dotlottie_converter.dart';
import '../loaders/abstarct_loader.dart';
import '../models/dotlottie_models.dart';
import '../util.dart';
import 'loader_io.dart' if (dart.library.html) 'loader_web.dart' as network;

/// Concrete [AbstractLoader] that loads from network
class NetworkLoader extends AbstractLoader {
  final String url;

  /// Custom http headers
  final Map<String, String>? headers;

  String get keyName => url.lastSegmentName();

  NetworkLoader(this.url, {this.headers});

  @override
  Future<DotLottie> load() {
    return sharedLottieCache.putIfAbsent(this, () async {
      var resolved = Uri.base.resolve(url);
      var bytes = await network.loadHttp(resolved, headers: headers);

      return await DotLottieConverter.fromBytes(bytes, name: keyName);
    });
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    return other is NetworkLoader && other.url == url;
  }

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => '$runtimeType(url: $url)';
}
