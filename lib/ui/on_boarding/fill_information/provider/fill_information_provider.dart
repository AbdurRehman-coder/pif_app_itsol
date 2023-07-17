import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/state/fill_information_state.dart';

final fillInformationProvider = StateNotifierProvider.autoDispose<
    FillInformationNotifier, FillInformationState>((ref) {
  return FillInformationNotifier(ref: ref);
});

class FillInformationNotifier extends StateNotifier<FillInformationState> {
  FillInformationNotifier({required this.ref})
      : super(FillInformationState.initial()) {
    init();
  }

  final Ref ref;
  final nationalController = TextEditingController();
  List<NationalityModel> nationalityModelList = List.generate(
    4,
    (index) => NationalityModel(
      nationalityText: 'NationalityText $index',
    ),
  ).toList();

  void init() {
    state = state.copyWith(nationalList: AsyncData(nationalityModelList));
  }

  void updateIndexSelect() {
    state = state.copyWith(selectedScreen: 1);
  }

  void selectImageFace({
    required File imageSelected,
  }) {
    state = state.copyWith(scanFace: imageSelected);
  }

  void removeSelectedImageFace() {
    state = state.copyWith(scanFace: null);
  }
}
