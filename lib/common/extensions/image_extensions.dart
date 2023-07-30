import 'package:dixels_sdk/dixels_sdk.dart';

extension ImageExt on ImagePrimary {
  String get getImageUrl {
    var url = '';
    if (link != null || link!.href!.isNotEmpty) {
      final endIndex = link!.href!.indexOf(link!.label!);
      if (endIndex != -1) {
        url = link!.href!.substring(0, endIndex) + link!.label!;
      }
    }
    return '${ServiceConstant.baseUrl}$url';
  }
}

extension ImageExtSecond on String {
  String get getImageUrl {
    return '${ServiceConstant.baseUrl}$this';
  }
}
