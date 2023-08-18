import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/notifications/provider/notification_provider.dart';
import 'package:pif_flutter/ui/notifications/widget/empty_notification.dart';
import 'package:pif_flutter/ui/notifications/widget/notification_card.dart';
import 'package:pif_flutter/ui/notifications/widget/notification_shimmer.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(
        // title: S.current.notifications,
        titleWidget: Text(
          S.current.notifications,
          style: Style.commonTextStyle(
            color: textColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BackgroundWidget(
        child: RefreshIndicator(
          onRefresh: notifier.loadNotifications,
          child: (provider.notificationList).when(
            data: (notifications) {
              if (notifications.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      /// Open Notification details
                      child: NotificationCard(
                        notification: notifications[index],
                      ),
                    ).visibility(visible: notifications[index].id != null);
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
                );
              } else {
                return const EmptyNotification();
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
      ),
    );
  }
}
