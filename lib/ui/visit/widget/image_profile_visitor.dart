import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class ImageProfileVisitor extends StatelessWidget {
  const ImageProfileVisitor({
    required this.firstName,
    required this.lastName,
    required this.status,
    super.key,
  });

  final String firstName;
  final String lastName;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status ? darkBlueColor : primaryColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}'.toUpperCase(),
        style: Style.commonTextStyle(
          color: whiteColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
