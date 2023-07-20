import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/dashboard/model/actions_model.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    required AsyncValue<List<ActionModel>> actionList,
  }) = _DashboardState;

  factory DashboardState.initial() => const DashboardState(
        actionList: AsyncLoading(),
      );
}
