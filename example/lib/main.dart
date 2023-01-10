import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/**
* library samples
* */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DotLottieLoader Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DotLottie Loader"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              ///Simple .Lottie Animation
              DotLottieLoader.fromAsset("assets/animation.lottie",
                  frameBuilder: (ctx, dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
              const SizedBox(height: 20),

              ///.Lottie Animation From network
              DotLottieLoader.fromNetwork(
                "https://github.com/sartajroshan/dotlottieloader-flutter/raw/master/example/assets/animation.lottie",
                frameBuilder: (ctx, dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie.animations.values.single,
                    );
                  } else {
                    return Container();
                  }
                },
                errorBuilder: (ctx, e, s) {
                  return Text(e.toString());
                },
              ),
              const SizedBox(height: 20),

              ///.lottie animation with external image
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
                  }),
              const SizedBox(height: 20),

              ///.lottie animation with inline image
              DotLottieLoader.fromAsset("assets/animation_inline_image.lottie",
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
