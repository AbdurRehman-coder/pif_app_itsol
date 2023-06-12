import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/visit/visit_list/state/visit_list_state.dart';

final visitListProvider =
    StateNotifierProvider.autoDispose<VisitListNotifier, VisitListState>((ref) {
  return VisitListNotifier(ref: ref);
});

class VisitListNotifier extends StateNotifier<VisitListState> {
  VisitListNotifier({required this.ref}) : super(VisitListState.initial());
  final searchVisitController = TextEditingController();
  final Ref ref;
}
