import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/services/index.dart';

class CreativeServiceView extends ConsumerWidget {
  const CreativeServiceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(serviceProvider);

    final data = provider.lstService;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10.w,
      ),
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: data[index].onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 68.w,
                width: 68.w,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: gray46.withOpacity(0.10),
                      offset: const Offset(0, 2),
                      blurRadius: 2.r,
                    ),
                  ],
                ),
                child: Image.asset(
                  data[index].image ?? '',
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                data[index].text ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
