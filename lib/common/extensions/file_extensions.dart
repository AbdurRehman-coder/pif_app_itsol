import 'dart:io';

extension FileUtils on String {
  double get getFileSizeMG {
    final sizeInBytes = File(this).lengthSync();
    final sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}
