import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/main.dart';
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
  late TextEditingController nationalController;
  var lstTypes = <LookUpModel>[];

  void init() {
    final lstData = <LookUpModel>[];
    lstData.add(LookUpModel(title: 'India', id: '1'));
    lstData.add(LookUpModel(title: 'Jordan', id: '2'));
    lstData.add(LookUpModel(title: 'Saudi Arabic', id: '3'));
    lstData.add(LookUpModel(title: 'Iran', id: '4'));
    lstData.add(LookUpModel(title: 'Kuwait', id: '5'));
    lstData.add(LookUpModel(title: 'Oman', id: '6'));
    if (camerasList.isNotEmpty) {
      state = state.copyWith(
        cameraController: CameraController(
          camerasList[1],
          ResolutionPreset.medium,
          enableAudio: false,
        ),
      );
    }

    state = state.copyWith(nationalList: AsyncData(lstData));
    nationalController = TextEditingController();

    lstTypes = <LookUpModel>[];
    lstTypes.add(LookUpModel(title: 'Passport', id: '1'));
    lstTypes.add(LookUpModel(title: 'Iqama', id: '2'));
  }

  void updateIndexSelect() {
    state = state.copyWith(selectedScreen: 1);
  }

  Future<void> initializeCamera() async {
    await state.cameraController?.initialize();
    state = state.copyWith(cameraController: state.cameraController);
  }

  Future<void> selectImageFace() async {
    final file = await state.cameraController?.takePicture();
    state = state.copyWith(scanFace: file);
  }

  void removeSelectedImageFace() {
    state = state.copyWith(scanFace: null);
  }

  void updateNationality(LookUpModel data) {
    state = state.copyWith(selectedNationality: data);
  }

  void updateType(LookUpModel data) {
    state = state.copyWith(selectedType: data);
  }

  void update() {
    state = state.copyWith();
  }

  void onVideoScanFaceFinish() {
    state = state.copyWith(isVideoFinish: true);
  }

  @override
  void dispose() {
    state.cameraController?.dispose();
    super.dispose();
  }
}
