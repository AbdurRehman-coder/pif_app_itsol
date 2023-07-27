import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';

class StoreCloseMessage extends StatelessWidget {
  const StoreCloseMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(drinksProvider);
        return Visibility(
          visible: provider.storeClosed,
          child: Column(
            children: [
              SizedBox(height: 13.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: primaryDisabledColor.withOpacity(0.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.r),
                  ),
                  border: Border.all(color: pendingStatusColor, width: 0.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.info,
                      color: primaryDarkColor,
                    ),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Text(
                        S.of(context).storeNotAvailable,
                        style: Style.commonTextStyle(
                          color: pendingStatusColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
