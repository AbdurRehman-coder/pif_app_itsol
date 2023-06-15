import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/invite_visitor/index.dart';
import 'package:pif_flutter/ui/invite_visitor/state/previous_visitor_state.dart';

final previousVisitorProvider =
    StateNotifierProvider.autoDispose<PreviousVisitorNotifier, PreviousVisitorState>((ref) {
  return PreviousVisitorNotifier(ref: ref);
});

class PreviousVisitorNotifier extends StateNotifier<PreviousVisitorState> {
  PreviousVisitorNotifier({required this.ref}) : super(PreviousVisitorState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController searchController;
  late FocusNode searchFocusNode = FocusNode();
  List<InviteVisitorModel> allData = <InviteVisitorModel>[];

  void _initData() {
    searchController = TextEditingController();
    final lstData = <InviteVisitorModel>[];
    lstData.add(
      InviteVisitorModel(
        'Abdul',
        'Moqatder',
        'test@yopmail.com',
        'Verified',
        false,
      ),
    );
    lstData.add(
      InviteVisitorModel(
        'Muath',
        'Awad',
        'muath@yopmail.com',
        'Verified',
        false,
      ),
    );
    lstData.add(
      InviteVisitorModel(
        'Alaa',
        'Awad',
        'alaa@yopmail.com',
        'Verified',
        false,
      ),
    );
    lstData.add(
      InviteVisitorModel(
        'Viral',
        'Panchal',
        'viral@yopmail.com',
        'Verified',
        false,
      ),
    );

    final selectedData = ref.read(inviteVisitorProvider);
    final lstSelected = selectedData.lstData.toList();
    for (final item in lstSelected) {
      final data =
          lstData.firstWhereOrNull((element) => element.email!.toLowerCase() == item.email!.toLowerCase());
      if (data != null) {
        data.isSelected = true;
      }
    }

    state = state.copyWith(lstData: lstData);
    allData = lstData;
  }

  void searchData(String searchText) {
    state = state.copyWith(isVisibleCancel: searchController.text.isNotEmpty);
    final lstData =
        allData.where((element) => element.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    state = state.copyWith(lstData: lstData);
  }

  void clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
    state = state.copyWith(lstData: allData);
    state = state.copyWith(isVisibleCancel: false);
  }

  void updateListData(InviteVisitorModel inviteModel) {
    final index = state.lstData.indexOf(inviteModel);
    if (index != -1) {
      state.lstData[index].isSelected = !state.lstData[index].isSelected!;
    }

    state = state.copyWith(lstData: state.lstData);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
