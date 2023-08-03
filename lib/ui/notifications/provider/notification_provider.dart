import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/widget/sliding_toast_notification.dart';
import 'package:pif_flutter/ui/notifications/model/notification_model.dart';
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
    try {
      state = const NotificationState(notificationList: AsyncLoading());
      final notifications = await fetchNotifications();
      state = NotificationState(notificationList: AsyncData(notifications));
    } catch (e, stackTrace) {
      state = NotificationState(notificationList: AsyncError(e, stackTrace));
    }
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 2));

    /// static list of notification Model
    return [
      NotificationModel(
        title: 'Drink order has been placed',
        time: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      NotificationModel(
        title: 'Upcoming Visit reminder in 30 mints',
        time: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        title: 'Booking approved Madan Saleh booking request is confirmed',
        time: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      NotificationModel(
        title: 'Upcoming Visit reminder in 30 mints',
        time: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }

  /// show the sliding toast notification
  void showSlidingToast(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Center(
          child: SlidingToast(
            message: 'Space Booked, did you book this by mistake?',
            onCancel: () {
              // Handle cancel booking
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Booking canceled!',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
