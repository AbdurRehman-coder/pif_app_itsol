import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/support/model/attachment_response_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/ticket_category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/state/add_ticket_state.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';

final addOrEditTicketProvider = StateNotifierProvider.autoDispose<
    AddOrEditTicketNotifier, AddOrEditTicketState>((ref) {
  return AddOrEditTicketNotifier(ref: ref);
});

class AddOrEditTicketNotifier extends StateNotifier<AddOrEditTicketState> {
  AddOrEditTicketNotifier({required this.ref})
      : super(AddOrEditTicketState.initial());

  final issueDescriptionController = TextEditingController();
  final Ref ref;
  final picker = ImagePicker();

  void onDeleteFile() {
    state = state.copyWith(image: null);
  }

  void onSelectCategory({
    required TicketCategoryModel item,
    AddTicketModel? addTicketModel,
  }) {
    final lstData = state.lstCategory.value!.toList();
    for (final element in lstData) {
      element.isSelected = false;
    }

    state = state.copyWith(selectedCategory: item);
    state = state.copyWith(selectedSubCategory: null);
    final selectedItem =
        lstData.firstWhereOrNull((element) => element.id == item.id);
    selectedItem!.isSelected = true;

    getSubCategoriesAsync(
      id: selectedItem.id!,
      addTicketModel: addTicketModel,
    );

    state = state.copyWith(lstCategory: AsyncData(lstData));
  }

  Future<void> createTicketAsync({required BuildContext context}) async {
    final desc = issueDescriptionController.text.trim();

    if (desc.isEmpty) {
      alertMessage(errorMessage: S.current.fillDescription, context: context);
      return;
    }

    if (state.selectedCategory == null) {
      alertMessage(errorMessage: S.current.selectTeam, context: context);
      return;
    }

    if (state.selectedSubCategory == null) {
      alertMessage(errorMessage: S.current.selectSubCategory, context: context);
      return;
    }

    final requestModel = <String, dynamic>{
      'categoryId': state.selectedCategory?.id,
      'subCategoryId': state.selectedSubCategory?.id,
      'description': desc,
    };

    final appProgress = AppProgressDialog(context: context);
    await appProgress.start();
    if (state.image != null) {
      final response = await uploadAttachmentAsync(
        fileName: state.image!.name,
        filePath: state.image!.path,
      );
      if (response != null) {
        requestModel['attachment'] = response.id;
      }
    }

    final result = await DixelsSDK.instance.supportService.postPageData(
      reqModel: requestModel,
      fromJson: SupportTicketModel.fromJson,
    );
    await appProgress.stop();
    if (result != null) {
      await ref.read(myTicketsProvider.notifier).getMyTickets();
      await AppRouter.pop();
    }
  }

  Future<void> uploadImage() async {
    state = state.copyWith(loadImage: true);
    final imageSelected = await picker.pickImage(source: ImageSource.gallery);
    state = state.copyWith(loadImage: false);
    if (imageSelected != null) {
      state = state.copyWith(image: imageSelected);
    }
  }

  void updateSubCategory({required TicketCategoryModel item}) {
    state = state.copyWith(selectedSubCategory: item);
  }

  Future<AttachmentResponseModel?> uploadAttachmentAsync({
    required String fileName,
    required String filePath,
  }) async {
    return DixelsSDK.instance.supportService.uploadAttachmentAsync(
      fileName: fileName,
      filePath: filePath,
    );
  }

  Future<void> getCategoriesAsync({
    AddTicketModel? addTicketModel,
  }) async {
    final result =
        await DixelsSDK.instance.supportService.getTicketCategories();
    if (result != null) {
      state = state.copyWith(lstCategory: AsyncData(result.items!));
      if (addTicketModel?.idSelectedCategory != null) {
        final category = result.items!
            .where(
              (element) => element.id == addTicketModel?.idSelectedCategory,
            )
            .firstOrNull;
        if (category != null) {
          onSelectCategory(
            item: category,
            addTicketModel: addTicketModel,
          );
        }
      }
    }
  }

  Future<void> getSubCategoriesAsync({
    required String id,
    AddTicketModel? addTicketModel,
  }) async {
    final result = await DixelsSDK.instance.supportService
        .getTicketSubCategories(categoryId: id);
    if (result != null) {
      state = state.copyWith(lstSubCategory: result.items!);
      if (addTicketModel?.isSelectedSubCategory != null &&
          addTicketModel?.isSelectedSubCategory != '') {
        final subCategory = result.items!
            .where(
              (element) => element.id == addTicketModel?.isSelectedSubCategory,
            )
            .firstOrNull;
        if (subCategory != null) {
          updateSubCategory(item: subCategory);
        }
      }
    }
  }
}
