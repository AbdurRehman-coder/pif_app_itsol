import 'package:flutter/material.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/colors.dart';

class SpaceBookingModel {
  SpaceBookingModel({
    required this.backImage,
    required this.buildingNo,
    required this.floorNo,
    required this.spaceName,
    required this.availableSheet,
    required this.isRequestToApprove,
  });

  String? buildingNo;
  String? floorNo;
  String? spaceName;
  String? availableSheet;
  String? backImage;
  bool isRequestToApprove;

  String get btnTitle => isRequestToApprove ? S.current.requestToBook : S.current.book;

  Color get btnBgColor => isRequestToApprove ? whiteColor : primaryColor;

  Color get btnTitleColor => isRequestToApprove ? primaryColor : whiteColor;
}
