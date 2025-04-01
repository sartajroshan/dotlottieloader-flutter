import 'package:http/http.dart';
import 'package:web/web.dart' as web;
import 'dart:typed_data';
import 'dart:js_interop' as js;

/// Load file from network
Future<Uint8List> loadHttp(Uri uri, {Map<String, String>? headers}) async {
  final response = await get(uri, headers: headers);
  return Uint8List.fromList(response.bodyBytes);
}

Future<Uint8List> loadFile(Object file) {
  return _loadBlob(file as web.Blob);
}

Future<Uint8List> _loadBlob(web.Blob file) async {
  var reader = web.FileReader();
  reader.readAsArrayBuffer(file);

  await reader.onLoadEnd.first;
  if (reader.readyState != web.FileReader.DONE) {
    throw Exception('Error while reading blob');
  }

  final result = reader.result;
  if (result == null) {
    throw Exception('No result from FileReader');
  }

  if (!result.isA<js.JSArrayBuffer>()) {
    throw Exception(
        'Unexpected result type from FileReader: ${result.runtimeType}');
  }

  // Safely convert the ArrayBuffer to Uint8List
  return _arrayBufferToUint8List(result as js.JSArrayBuffer);
}

String filePath(Object file) {
  return (file as web.File).name;
}

Uint8List _arrayBufferToUint8List(js.JSArrayBuffer buffer) {
  return Uint8List.view(buffer.toDart);
}
