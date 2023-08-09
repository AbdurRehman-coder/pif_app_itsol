import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/users/add_image/model/add_image_request.dart';
import 'package:dixels_sdk/features/users/country/model/country_model.dart';
import 'package:dixels_sdk/features/users/verify_users/model/verify_user_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/file_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/main.dart';
import 'package:pif_flutter/routes/routes.dart';
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
  late TextEditingController iDController;
  var lstTypes = <TypeModel>[];
  final idNumberFocusNode = FocusNode();
  final lstData = <TypeModel>[];

  void init() {
    lstTypes = <TypeModel>[];
    iDController = TextEditingController();
    lstTypes.add(TypeModel(title: 'Passport', id: '1'));
    lstTypes.add(TypeModel(title: 'Iqama', id: '2'));
    state = state.copyWith(typeList: AsyncData(lstTypes));
    getCountries();
    if (camerasList.isNotEmpty) {
      state = state.copyWith(
        cameraController: CameraController(
          camerasList[1],
          ResolutionPreset.medium,
          enableAudio: false,
        ),
      );
    }
  }

  void updateIndexSelect() {
    state = state.copyWith(selectedScreen: 1);
  }

  Future<void> initializeCamera() async {
    await state.cameraController?.initialize();
    state = state.copyWith(cameraController: state.cameraController);
  }

  void removeSelectedImageFace() {
    state = state.copyWith(scanFace: null);
  }

  void updateCountry(CountryModel data) {
    state = state.copyWith(selectedNationality: data);
    iDController.clear();
    if (data.a2 == 'SA') {
      state = state.copyWith(selectedType: null);
    }
  }

  void updateType(TypeModel data) {
    state = state.copyWith(selectedType: data);
  }

  void update() {
    state = state.copyWith();
  }

  void onVideoScanFaceFinish({required bool isVideoFinish}) {
    state = state.copyWith(isVideoFinish: isVideoFinish);
  }

  //Update Terms And Condition Value
  void updateTermsAndCondition({required bool termsAndCondition}) {
    state = state.copyWith(acceptTermsAndCondition: termsAndCondition);
  }

  //Update IDType
  void updateIDType({required TypeModel typeSelected}) {
    iDController.clear();
    state = state.copyWith(selectedType: typeSelected);
  }

  //Update Terms And Condition Value
  void updateNDA({required bool nda}) {
    state = state.copyWith(acceptNDA: nda);
  }

  Future<void> getCountries() async {
    final result = await DixelsSDK.instance.countryService.getCountries();
    if (result.isRight()) {
      state = state.copyWith(
        countryList: AsyncData(
          result.getRight()?.items ?? [],
        ),
      );
      await getInformation();
    }
  }

  Future<void> getInformation() async {
    final information = await DixelsSDK.instance.structureContentService
        .getStructureContentByKey(webContentId: '199522', siteId: '20120');
    if (information != null) {
      state = state.copyWith(contentModel: AsyncData(information));
    }
  }

  Future<void> scrollToIndex() async {
    await state.scrollControllerFillInformation.animateTo(
      100,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
    );
    update();
  }

  Future<void> checkImage({required BuildContext context}) async {
    final fileSelected = await state.cameraController?.takePicture();
    if (fileSelected != null) {
      final appProgress = AppProgressDialog(context: context);
      await appProgress.start();

      final imageFile = File(fileSelected.path);

      final checkImage = await DixelsSDK.instance.addImageService.addImage(
        addImageRequest: AddImageRequest(
          base64Image: imageFile.convertFileToBase64,
        ),
      );
      await appProgress.stop();
      if (checkImage.isRight()) {
        final minQuality = double.parse(
          state.contentModel?.value?.contentFields
                  ?.where(
                    (
                      content,
                    ) =>
                        content.name == 'sensetimeImageScoreThreshold',
                  )
                  .firstOrNull
                  ?.contentFieldValue
                  ?.data ??
              '',
        );
        if (checkImage.getRight()!.quality >= minQuality) {
          state = state.copyWith(scanFace: fileSelected);
        } else {
          alertMessage(
            errorMessage: S.current.imageError,
            context: context,
          );
        }
      }
    }
  }

  Future<void> verifyUser({required BuildContext context}) async {
    final appProgress = AppProgressDialog(context: context);
    await appProgress.start();
    final isSaudi = state.selectedNationality?.a2 == 'SA';
    final isPassport = state.selectedType?.id == '1';
    final isIqama = state.selectedType?.id == '2';
    final verifyUser = await DixelsSDK.instance.verifyUserService.verifyUser(
      verifyUserRequestModel: VerifyUserRequestModel(
        nationality: state.selectedNationality?.title_i18n?.en_US ?? '',
        nationalId: isSaudi ? iDController.text : '',
        passportId: isPassport ? iDController.text : '',
        residentId: isIqama ? iDController.text : '',
      ),
    );
    await appProgress.stop();
    if (verifyUser.isRight()) {
      await AppRouter.startNewRoute(Routes.dashboardScreen);
    } else {
      alertMessage(
        errorMessage: verifyUser.getLeft().message,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    state.cameraController?.dispose();
    super.dispose();
  }
}
