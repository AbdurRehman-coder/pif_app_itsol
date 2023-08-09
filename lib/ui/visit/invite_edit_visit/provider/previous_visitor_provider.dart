import 'package:collection/collection.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/state/previous_visitor_state.dart';

final previousVisitorProvider = StateNotifierProvider.autoDispose<
    PreviousVisitorNotifier, PreviousVisitorState>((ref) {
  return PreviousVisitorNotifier(ref: ref);
});

class PreviousVisitorNotifier extends StateNotifier<PreviousVisitorState> {
  PreviousVisitorNotifier({required this.ref})
      : super(PreviousVisitorState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController searchController;
  late FocusNode searchFocusNode = FocusNode();
  List<InviteVisitorModel> allData = <InviteVisitorModel>[];

  void _initData() {
    searchController = TextEditingController();

    final selectedData = ref.read(inviteVisitorProvider);
    final lstData = selectedData.visitorModelList.value
        ?.map(
          (visitor) => InviteVisitorModel(
            visitor.givenName,
            visitor.familyName,
            visitor.emailAddress,
            fromHistory: true,
            isVisitorVerified: true,
          ),
        )
        .toList();
    final lstSelected = selectedData.lstData.toList();
    for (final item in lstSelected) {
      final data = lstData!.firstWhereOrNull(
        (element) => element.email!.toLowerCase() == item.email!.toLowerCase(),
      );
      if (data != null) {
        data.isSelected = true;
      }
    }

    state = state.copyWith(previousVisitorList: lstData!);
    allData = lstData;
  }

  void searchData(String searchText) {
    state = state.copyWith(isVisibleCancel: searchController.text.isNotEmpty);
    final lstData = allData
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
    state = state.copyWith(previousVisitorList: lstData);
  }

  void clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
    state = state.copyWith(previousVisitorList: allData);
    state = state.copyWith(isVisibleCancel: false);
  }

  void updateListData({
    required BuildContext context,
    required InviteVisitorModel inviteModel,
  }) {
    final index = state.previousVisitorList.indexWhere(
      (element) => element == inviteModel,
    );
    if (index != -1) {
      final notifier = ref.read(inviteVisitorProvider.notifier);
      if (notifier.visitorNotFoundLocally(email: inviteModel.email ?? '') ||
          state.previousVisitorList[index].isSelected) {
        state.previousVisitorList[index].isSelected =
            !state.previousVisitorList[index].isSelected;
        if (!state.previousVisitorList[index].isSelected) {
          notifier.removeVisitor(inviteModel);
        }
      } else {
        alertMessage(
          errorMessage: S.current.visitorAlreadyFound,
          context: context,
        );
      }
    }
    state = state.copyWith(previousVisitorList: state.previousVisitorList);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
