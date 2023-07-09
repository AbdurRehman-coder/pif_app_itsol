import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class BannerTextView extends StatelessWidget {
  const BannerTextView({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      alignment: Alignment.center,
      child: Text(
        text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: Style.commonTextStyle(
          color: hintColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
