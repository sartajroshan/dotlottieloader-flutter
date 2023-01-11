import 'dart:io';

import 'package:flutter/foundation.dart';

final HttpClient _sharedHttpClient = HttpClient()..autoUncompress = false;

/// Load file from network
Future<Uint8List> loadHttp(Uri uri, {Map<String, String>? headers}) async {
  var request = await _sharedHttpClient.getUrl(uri);
  headers?.forEach((String name, String value) {
    request.headers.add(name, value);
  });
  final response = await request.close();
  if (response.statusCode != HttpStatus.ok) {
    throw Exception('Http error. Status code: ${response.statusCode} for $uri');
  }

  final bytes = await consolidateHttpClientResponseBytes(response);
  if (bytes.lengthInBytes == 0) {
    throw Exception('NetworkImage is an empty file: $uri');
  }

  return bytes;
}

Future<Uint8List> loadFile(Object file) {
  return (file as File).readAsBytes();
}

String filePath(Object file) {
  return (file as File).path;
}
