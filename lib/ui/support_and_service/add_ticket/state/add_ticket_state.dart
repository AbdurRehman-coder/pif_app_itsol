import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/subcategory_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/teams_model.dart';

part 'add_ticket_state.freezed.dart';

@freezed
class AddOrEditTicketState with _$AddOrEditTicketState {
  const factory AddOrEditTicketState({
    required XFile? image,
    required bool loadImage,
    required bool isTeamSelected,
    required AsyncValue<List<TeamsModel>> teamList,
      required SubCategoryModel? subcategorySelected,
    required AsyncValue<List<SubCategoryModel>> subCategoryList,
  }) = _AddOrEditTicketState;

  factory AddOrEditTicketState.initial() => const AddOrEditTicketState(
        image: null,
        loadImage: false,
    isTeamSelected: false,
        subcategorySelected: null,
        teamList: AsyncLoading(),
        subCategoryList: AsyncLoading(),
      );
}
