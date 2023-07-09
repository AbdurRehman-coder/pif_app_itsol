import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    final data = provider.lstCategory;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 40.h,
          mainAxisSpacing: 10.w,
          childAspectRatio: 0.7,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 78.h,
            width: 60.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.w,
                  width: 60.w,
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: whiteColor,
                    border: Border.all(
                      width: 1.5,
                      color: grayD7,
                    ),
                  ),
                  child: Image.asset(
                    data[index].image ?? '',
                    fit: BoxFit.scaleDown,
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  data[index].text ?? '',
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
