import 'package:dixels_sdk/features/commerce/support/model/ticket_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

part 'add_ticket_state.freezed.dart';

@freezed
class AddOrEditTicketState with _$AddOrEditTicketState {
  const factory AddOrEditTicketState({
    required XFile? image,
    required bool loadImage,
    required TicketCategoryModel? selectedCategory,
    required TicketCategoryModel? selectedSubCategory,
    required AsyncValue<List<TicketCategoryModel>> lstCategory,
    required List<TicketCategoryModel> lstSubCategory,
  }) = _AddOrEditTicketState;

  factory AddOrEditTicketState.initial() => const AddOrEditTicketState(
        image: null,
        loadImage: false,
        selectedCategory: null,
        selectedSubCategory: null,
        lstCategory: AsyncLoading(),
        lstSubCategory: <TicketCategoryModel>[],
      );
}
