import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/notifications/state/notification_state.dart';

final notificationProvider =
    StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>(
        (ref) {
  return NotificationNotifier(ref: ref);
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier({required this.ref})
      : super(NotificationState.initial()) {
    _initData();
  }

  final Ref ref;

  void _initData() {
    /// load notification asynchronously
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final result =
        await DixelsSDK.instance.notificationService.getAllNotification(
      params: ParametersModel(sort: 'dateCreated:desc'),
    );
    if (result.isRight()) {
      state = NotificationState(
        notificationList: AsyncData(
          result.getRight()?.items ?? [],
        ),
      );
      await readNotifications();
    }
  }

  Future<void> readNotifications() async {
    final result =
        await DixelsSDK.instance.notificationService.readNotification();
    if (result.isRight()) {
      if (result.getRight()!.status?.toLowerCase() == 'ok') {
        final notifier = ref.read(dashboardProvider.notifier);
        await notifier.getUnReadNotificationCount();
      }
    }
  }
}
