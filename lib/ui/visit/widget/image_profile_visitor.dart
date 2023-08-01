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
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
