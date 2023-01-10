import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dotlottie_loader/src/util.dart';

import 'models/dotlottie_models.dart';


class DotLottieConverter {
  static Future<DotLottie> fromByteData(ByteData data, {String? name}) {
    return fromBytes(data.buffer.asUint8List(), name: name);
  }

  static Future<DotLottie> fromBytes(Uint8List bytes, {String? name}) async {
    Archive? archive;
    Manifest? manifest;
    Map<String, Uint8List> animations = {};
    Map<String, Uint8List> images = {};
    if (bytes[0] == 0x50 && bytes[1] == 0x4B) {
      archive = ZipDecoder().decodeBytes(bytes);
      // var jsonFile = archive.files.firstWhere((e) => e.name.endsWith('.json'));
      // bytes = jsonFile.content as Uint8List;
    } else {
      animations[name!.lastSegmentName().withoutExt()] = bytes;
    }

    if (archive != null) {
      Future.forEach(archive, (file) async {
        if (file.name.toLowerCase() == 'manifest.json') {
          try {
            final content = file.content as Uint8List;
            final jsonString = const Utf8Decoder()
                .convert(content.toList()); //File.fromRawPath(content).
            //print(jsonString);
            Map<String, dynamic> jsonData = jsonDecode(jsonString);
            manifest = Manifest.fromJson(jsonData);
          } catch (e) {
            log('$e');
          }
        } else if (file.name.startsWith("animations/")) {
          animations[file.name.lastSegmentName().withoutExt()] = file.content;
        } else if (file.name.startsWith("images/")) {
          images[file.name.lastSegmentName()] = file.content;
        } else if (file.name.contains(".json")) {
          animations[file.name.lastSegmentName().withoutExt()] = file.content;
        } else if (file.name.contains(".png") || file.name.contains(".webp")) {
          images[file.name.lastSegmentName()] = file.content;
        }
      });
    }

    return DotLottie(manifest, animations, images);
  }

  DotLottieConverter._(this.name);

  final String? name;
}
