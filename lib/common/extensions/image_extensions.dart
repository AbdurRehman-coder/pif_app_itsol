import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:pif_flutter/helpers/constants.dart';

extension ImageExt on ImagePrimary {
  String get getImageUrl {
    var url = '';
    if (link != null || link!.href!.isNotEmpty) {
      final endIndex = link!.href!.indexOf(link!.label!);
      if (endIndex != -1) {
        url = link!.href!.substring(0, endIndex) + link!.label!;
      }
    }
    return '${Constants.baseUrl}$url';
  }
}

extension ImageExtSecond on String {
  String get getImageUrl {
    return '${Constants.baseUrl}$this';
  }
}
