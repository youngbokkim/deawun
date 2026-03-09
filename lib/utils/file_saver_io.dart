import 'dart:io';
import 'dart:typed_data';

Future<void> saveBytesToFile(String path, Uint8List bytes) async {
  await File(path).writeAsBytes(bytes);
}
