import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/subcategory_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/teams_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/state/add_ticket_state.dart';

final addOrEditTicketProvider = StateNotifierProvider.autoDispose<
    AddOrEditTicketNotifier, AddOrEditTicketState>((ref) {
  return AddOrEditTicketNotifier(ref: ref);
});

class AddOrEditTicketNotifier extends StateNotifier<AddOrEditTicketState> {
  AddOrEditTicketNotifier({required this.ref})
      : super(AddOrEditTicketState.initial()) {
    _initData();
  }

  final issueDescriptionController = TextEditingController();
  final Ref ref;
  final picker = ImagePicker();

  void _initData() {
    getTeamList();
  }

  void onDeleteFile() {
    state = state.copyWith(image: null);
  }

  void onUpdateItem({required TeamsModel teamsSelect}) {
    final teamList = state.teamList.value!;
    teamList
        .where((element) => element.isTeamSelected)
        .any((element) => element.isTeamSelected = false);
    final teamSelected = teamList
        .where(
          (team) => team == teamsSelect,
        )
        .firstOrNull;
    if (teamSelected != null) {
      teamSelected.isTeamSelected = !teamSelected.isTeamSelected;

      ///Todo: Fill category id
      getSubCategoryList(categoryId: 1);
      state = state.copyWith(isTeamSelected: true);
    }

    state = state.copyWith(teamList: AsyncData(teamList));
  }

  Future<void> createTicket({required BuildContext context}) async {
    if (issueDescriptionController.text.isNotEmpty &&
        state.isTeamSelected &&
        state.subcategorySelected != null) {
      /// Todo : Implment API to add ticket
      print('All Selected');
    } else if (issueDescriptionController.text.isNotEmpty) {
      alertMessage(errorMessage: S.current.fillDescription, context: context);
    } else if (!state.isTeamSelected) {
      alertMessage(errorMessage: S.current.selectTeam, context: context);
    } else {
      alertMessage(errorMessage: S.current.selectSubCategory, context: context);
    }
  }

  Future<void> getTeamList() async {
    state = state.copyWith(
      teamList: AsyncData(
        List.generate(
          4,
          (index) => TeamsModel(
            teamImage:
                'https://upload.wikimedia.org/wikipedia/commons/c/c6/Sign-check-icon.png',
            teamText: 'Space & Logistics',
          ),
        ).toList(),
      ),
    );
  }

  Future<void> getSubCategoryList({required int categoryId}) async {
    final subCategoryData = List.generate(
      5,
      (index) => SubCategoryModel(subcategoryText: 'Space Access $index'),
    ).toList();
    state = state.copyWith(subCategoryList: AsyncData(subCategoryData));
  }

  Future<void> uploadImage() async {
    state = state.copyWith(loadImage: true);
    final imageSelected = await picker.pickImage(source: ImageSource.gallery);
    state = state.copyWith(loadImage: false);
    if (imageSelected != null) {
      state = state.copyWith(image: imageSelected);
    }
  }

  void updateSubCategory({required SubCategoryModel subcategorySelected}) {
    state = state.copyWith(subcategorySelected: subcategorySelected);
  }
}
