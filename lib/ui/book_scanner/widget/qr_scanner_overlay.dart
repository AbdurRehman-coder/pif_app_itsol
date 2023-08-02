import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/utils/colors.dart';

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({super.key, this.overlayColour = Colors.green});

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    final scanArea = context.screenWidth - 80;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            gradientEnd.withOpacity(0.3),
            BlendMode.srcOut,
          ), // This one will create the magic
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: gradientEnd.withOpacity(0.5),
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Padding(
                padding: EdgeInsets.only(top: 80.h, left: 40.w, right: 40.w),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: scanArea,
                    width: scanArea,
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(53.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
