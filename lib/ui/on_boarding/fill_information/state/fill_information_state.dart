import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';

part 'fill_information_state.freezed.dart';

@freezed
class FillInformationState with _$FillInformationState {
  const factory FillInformationState({
    required int selectedScreen,
    required AsyncValue<List<NationalityModel>> nationalList,
    required File? scanFace,
    required NationalityModel? nationalitySelect,
  }) = _FillInformationState;

  factory FillInformationState.initial() => const FillInformationState(
        nationalitySelect: null,
        scanFace: null,
        selectedScreen: 0,
        nationalList: AsyncLoading(),
      );
}
