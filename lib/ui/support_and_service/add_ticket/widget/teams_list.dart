import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/provider/add_ticket_provider.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/state/add_ticket_state.dart';

class TeamsList extends ConsumerWidget {
  const TeamsList({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final AddOrEditTicketNotifier notifier;
  final AddOrEditTicketState provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return provider.lstCategory.when(
      data: (data) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.h,
            mainAxisSpacing: 10.w,
            mainAxisExtent: 120.h,
          ),
          itemBuilder: (_, index) {
            final item = data[index];
            return InkWell(
              onTap: () => notifier.onSelectCategory(item: item),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 10.w,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.r),
                  ),
                  border: item.isSelected ?? false
                      ? Border.all(color: primaryColor)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.spaceIcon,
                      height: 50.h,
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: Text(
                        item.name ?? '',
                        textAlign: TextAlign.center,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (e, s) {
        return const SizedBox();
      },
      loading: () {
        return const SizedBox();
      },
    );
  }
}
