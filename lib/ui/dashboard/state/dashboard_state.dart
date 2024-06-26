import 'package:dixels_sdk/features/commerce/account/model/user_model.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/dashboard/model/actions_model.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    required AsyncValue<List<ActionModel>> actionList,
    required AsyncValue<StructureContentModel> structureContent,
    required bool storeClosed,
    required int? unReadNotification,
    required UserModel? userDetails,
  }) = _DashboardState;

  factory DashboardState.initial() => const DashboardState(
        actionList: AsyncLoading(),
        structureContent: AsyncLoading(),
        storeClosed: false,
        unReadNotification: null,
        userDetails: null,
      );
}
