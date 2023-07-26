import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';

part 'fill_information_state.freezed.dart';

@freezed
class FillInformationState with _$FillInformationState {
  const factory FillInformationState({
    required int selectedScreen,
    required bool isVideoFinish,
    required bool isDropDownOpen,
    required ScrollController scrollControllerFillInformation,
    required CameraController? cameraController,
    required AsyncValue<List<LookUpModel>> nationalList,
    required XFile? scanFace,
    required LookUpModel? selectedNationality,
    required LookUpModel? selectedType,
  }) = _FillInformationState;

  factory FillInformationState.initial() => FillInformationState(
        selectedNationality: null,
        scanFace: null,
        isVideoFinish: false,
        isDropDownOpen: false,
        scrollControllerFillInformation: ScrollController(),
        cameraController: null,
        selectedScreen: 0,
        nationalList: const AsyncLoading(),
        selectedType: null,
      );
}
