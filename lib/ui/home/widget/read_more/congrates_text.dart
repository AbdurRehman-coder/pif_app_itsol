import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pif_flutter/common/index.dart';

class CongratsText extends StatelessWidget {
  const CongratsText({
    required this.newsDescription,
    super.key,
  });

  final String newsDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: HtmlWidget(
            newsDescription,
            textStyle: Style.commonTextStyle(
              color: blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
