
import 'package:dixels_sdk/features/users/notification/model/notification_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
   required AsyncValue<List<NotificationModel>> notificationList,
  }) = _NotificationState;

  factory NotificationState.initial() => const NotificationState(
    notificationList: AsyncLoading(),
  );
}