import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/ui/book_scanner/widget/qrcod_border.dart';
import 'package:pif_flutter/utils/colors.dart';

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({super.key, this.overlayColour = Colors.green});

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    final scanArea = 320.0.w;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColour,
            BlendMode.srcOut,
          ), // This one will create the magic
          child: Stack(
            children: [
              Container(
                decoration:  const BoxDecoration(
                  color: borderColor,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 35.h),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: scanArea,
                    width: scanArea,
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(70.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Align(
            alignment: Alignment.topCenter,
            child: CustomPaint(
              foregroundPainter: ScanQRCodeBorder(),
              child: SizedBox(
                width: scanArea + 10,
                height: scanArea + 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Creates the white borders

