import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            children: [
              DotLottieLoader.fromAsset("assets/anim2.lottie",
                  frameBuilder: (ctx, dotlottie) {
                return Lottie.memory(dotlottie!.animations.values.single);
              }),
              const SizedBox(height: 20),
              DotLottieLoader.fromNetwork("assets/anim2.lottie",
                  frameBuilder: (ctx, dotlottie) {
                if(dotlottie != null) {
                  return Lottie.memory(dotlottie!.animations.values.single);
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
