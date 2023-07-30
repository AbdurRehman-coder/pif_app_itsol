import 'dart:convert';
import 'dart:io';

extension FileUtils on String {
  double get getFileSizeMG {
    final sizeInBytes = File(this).lengthSync();
    final sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}

extension FileExtention on File {
  String get convertFileToBase64 {
    final bytes = readAsBytesSync();
    return base64Encode(bytes);
  }
}
