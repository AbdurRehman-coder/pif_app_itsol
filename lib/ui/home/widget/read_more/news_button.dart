import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class NewsButton extends StatelessWidget {
  const NewsButton({
    required this.newsType,
    super.key,
  });

  final String newsType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      decoration: kGradientBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Container(
          alignment: Alignment.center,
          decoration: kInnerDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              // vertical: 2.h,
            ),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Color(0xFF088542), Color(0xFFC29B5B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                newsType,
                style: Style.commonTextStyle(
                  color: darkBorderColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Linear Gradients
final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(100),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient:
      const LinearGradient(colors: [Color(0xFF088542), Color(0xFFC29B5B)]),
  border: Border.all(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(100),
);
