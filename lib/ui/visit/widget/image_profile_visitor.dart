import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class ImageProfileVisitor extends StatelessWidget {
  const ImageProfileVisitor({
    required this.firstName,
    required this.lastName,
    super.key,
  });

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: RegExp(r'^[A-J_.]+$').hasMatch(firstName[0].toUpperCase())
            ? primaryColor
            : RegExp(r'^[K-S_.]+$').hasMatch(firstName[0].toUpperCase())
                ? goldenColor
                : darkBlueColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}'
            .toUpperCase(),
        style: Style.commonTextStyle(
          color: whiteColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
