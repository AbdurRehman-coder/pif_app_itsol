import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class ComingVisitorCard extends StatelessWidget {
  const ComingVisitorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.comingVisitorBackground,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.comingVisitor,
            style: Style.commonTextStyle(
              color: blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Khaled Ahmed',
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
