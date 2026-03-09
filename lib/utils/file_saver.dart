import 'dart:typed_data';
import 'file_saver_stub.dart' if (dart.library.io) 'file_saver_io.dart' as impl;

Future<void> saveBytesToFile(String path, Uint8List bytes) async {
  await impl.saveBytesToFile(path, bytes);
}
