import 'package:camera/camera.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:dixels_sdk/features/users/country/model/country_model.dart';
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
    required bool acceptTermsAndCondition,
    required bool acceptNDA,
    required ScrollController scrollControllerFillInformation,
    required CameraController? cameraController,
    required AsyncValue<List<TypeModel>> typeList,
    required AsyncValue<StructureContentModel>? contentModel,
    required AsyncValue<List<CountryModel>> countryList,
    required XFile? scanFace,
    required CountryModel? selectedNationality,
    required TypeModel? selectedType,
  }) = _FillInformationState;

  factory FillInformationState.initial() => FillInformationState(
        selectedNationality: null,
        scanFace: null,
        isVideoFinish: false,
        acceptTermsAndCondition: false,
        acceptNDA: false,
        scrollControllerFillInformation: ScrollController(),
        cameraController: null,
        selectedScreen: 0,
        typeList: const AsyncLoading(),
        countryList: const AsyncLoading(),
        contentModel: const AsyncLoading(),
        selectedType: null,
      );
}
