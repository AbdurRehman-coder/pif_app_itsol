import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class ImageProfileVisitor extends StatelessWidget {
  const ImageProfileVisitor({
    required this.firstName,
    required this.lastName,
    this.width = 40,
    this.height = 40,
    this.fontSize = 16,
    super.key,
  });

  final String firstName;
  final String lastName;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: RegExp(r'^[A-E_.]+$').hasMatch(firstName[0].toUpperCase())
            ? primary800
            : RegExp(r'^[J-M_.]+$').hasMatch(firstName[0].toUpperCase())
                ? blue400
                : RegExp(r'^[N-S_.]+$').hasMatch(firstName[0].toUpperCase())
                    ? pink200
                    : primary300,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}'
            .toUpperCase(),
        style: Style.commonTextStyle(
          color: whiteColor,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
