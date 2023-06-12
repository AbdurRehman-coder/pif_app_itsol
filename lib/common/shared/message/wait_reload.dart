import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/utils/colors.dart';

class AppWait extends StatelessWidget {
  const AppWait({
    super.key,
    this.withImage = false,
  });
  final bool withImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/ic_logo.png',
        height: 40.0.h,
        width: 40.0.w,
      ),
    );
  }
}
