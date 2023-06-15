import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/visit_list/model/visitor_status_model.dart';

part 'visit_list_state.freezed.dart';

@freezed
class VisitListState with _$VisitListState {
  const factory VisitListState({
    required AsyncValue<List<VisitModel>> allVisits,
    required List<VisitorStatusModel> lstStatus,
    required bool loadingData,
  }) = _VisitListState;

  factory VisitListState.initial() => const VisitListState(
        allVisits: AsyncLoading(),
        loadingData: true,
        lstStatus: <VisitorStatusModel>[],
      );
}
