import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.url,
    required this.withFree,
    super.key,
  });

  final String url;
  final bool withFree;

  @override
  Widget build(BuildContext context) {
    const startGradient = LinearGradient(
      begin: Alignment(0.49, -1.16),
      end: Alignment(-0.86, 1.68),
      colors: [
        Color.fromRGBO(0, 0, 0, 0.24),
        Color.fromRGBO(0, 0, 0, 0),
      ],
      stops: [0.1342, 1.0908],
    );

    const endGradient = LinearGradient(
      begin: Alignment(-0.44, -0.17),
      end: Alignment(1.1455, 2.5264),
      colors: [
        Color(0xFFB1B2AD),
        Color(0xFFE8E8E8),
      ],
      stops: [0.3659, 1.1455],
    );

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          child: Container(
            height: 100.h,
            width: 100.w,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: Gradient.lerp(startGradient, endGradient, 0.1),
            ),
            child: CachedNetworkImage(
              imageUrl: url,
              height: 70.h,
              width: 70.w,
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          ),
        ),
        Visibility(
          visible: withFree,
          child: Positioned(
            right: 0,
            child: SvgPicture.asset(Assets.freeTag),
          ),
        ),
      ],
    );
  }
}
