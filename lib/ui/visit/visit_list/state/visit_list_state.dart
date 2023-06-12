import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_list_state.freezed.dart';

@freezed
class VisitListState with _$VisitListState {
  const factory VisitListState() = _VisitListState;

  factory VisitListState.initial() => const VisitListState();
}
