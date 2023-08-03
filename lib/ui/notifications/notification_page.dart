import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/notifications/provider/notification_provider.dart';
import 'package:pif_flutter/ui/notifications/widget/notification_card.dart';
import 'package:pif_flutter/ui/notifications/widget/notification_shimmer.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);
    print(provider.notificationList.isLoading);
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).notifications,
      ),
      body: BackgroundWidget(
        child: (provider.notificationList).when(
          data: (data) {
            if (data.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          /// Just for testing the notification sliding toast
                          onTap: () => notifier.showSlidingToast(context),
                          child: NotificationCard(
                            notification: data[index],
                            index: index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Divider(
                            color: grayBorderColor,
                            height: 1.h,
                            thickness: 1,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
          error: (e, s) {
            return Container();
          },
          loading: () {
            return const NotificationShimmerWidget();
          },
        ),
      ),
    );
  }
}
