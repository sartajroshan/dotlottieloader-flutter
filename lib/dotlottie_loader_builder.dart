library dotlottie_loader;

import 'package:dotlottie_loader/loaders/abstarct_loader.dart';
import 'package:dotlottie_loader/loaders/asset_loader.dart';
import 'package:dotlottie_loader/loaders/file_loader.dart';
import 'package:dotlottie_loader/loaders/network_loader.dart';
import 'package:dotlottie_loader/models/dotlottie_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef DotLottieChildBuilder = Widget Function(
    BuildContext context,
    // Widget child,
    DotLottie? dotLottie,
    );

typedef DotLottieErrorWidgetBuilder = Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
    );

/// A widget that loads a DotLottie file.
///
/// Several constructors are provided for the various ways that a DotLottie file
/// can be loaded:
///
///  * [DotLottieLoader.fromAsset], for obtaining a DotLottie file from an [AssetBundle]
///    using a key.
///  * [DotLottieLoader.fromNetwork], for obtaining a DotLottie file from a URL.
///  * [DotLottieLoader.fromFile], for obtaining a DotLottie file from a [File].
///

class DotLottieLoader extends StatefulWidget {

  @override
  State<DotLottieLoader> createState() => _DotLottieLoaderState();

  final AbstractLoader dotlottieLoader;
  final DotLottieChildBuilder? frameBuilder;
  final DotLottieErrorWidgetBuilder? errorBuilder;

  DotLottieLoader.fromAsset(String name,
      {super.key,
        AssetBundle? bundle,
        String? package,
        required this.frameBuilder,
        this.errorBuilder})
      : dotlottieLoader = AssetLoader(name, bundle: bundle, package: package);

  DotLottieLoader.fromNetwork(String url,
      {super.key,
        Map<String, String>? headers,
        required this.frameBuilder,
        this.errorBuilder})
      : dotlottieLoader = NetworkLoader(url, headers: headers);

  DotLottieLoader.fromFile(Object file,
      {super.key,
        required this.frameBuilder,
        this.errorBuilder})
      : dotlottieLoader = FileLoader(file);
}

class _DotLottieLoaderState extends State<DotLottieLoader> {
  Future<DotLottie>? _loadingFuture;

  @override
  void initState() {
    super.initState();
    var provider = widget.dotlottieLoader;
    _loadingFuture = widget.dotlottieLoader.load().then((dotlottie) {
      if (mounted && widget.dotlottieLoader == provider) {
        //widget.onLoaded?.call(composition);
      }

      return dotlottie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DotLottie>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (widget.errorBuilder != null) {
              return widget.errorBuilder!(
                  context, snapshot.error!, snapshot.stackTrace);
            } else if (kDebugMode) {
              return ErrorWidget(snapshot.error!);
            }
          }

          if (widget.frameBuilder != null && snapshot.hasData) {
            return widget.frameBuilder!(context, snapshot.data);
          } else {
            return Container();
          }
        });
  }
}
