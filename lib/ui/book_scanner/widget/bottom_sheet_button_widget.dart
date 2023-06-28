import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  const BottomSheetButtonWidget({
    required this.bottomText,
    required this.onTap,
    super.key,
  });

  final String bottomText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: lightPrimaryColor,
          ),
          height: 80.h,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  Assets.downArrow,
                  colorFilter: const ColorFilter.mode(borderColor, BlendMode.srcIn),
                  height: 13.h,
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                bottomText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
