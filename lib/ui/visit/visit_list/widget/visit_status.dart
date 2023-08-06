import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/state/visit_list_state.dart';

class VisitStatus extends StatelessWidget {
  const VisitStatus({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final VisitListNotifier notifier;
  final VisitListState provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final item = provider.lstStatus[index];
          return InkWell(
            onTap: () => notifier.updateStatusList(index),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: grayGradientStart,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
                color: item.isSelected! ? secondary : whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: Text(
                item.title ?? '',
                style: Style.commonTextStyle(
                  color: item.isSelected! ? whiteColor : darkBorderColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(width: 8.w);
        },
        itemCount: provider.lstStatus.length,
      ),
    );
  }
}
