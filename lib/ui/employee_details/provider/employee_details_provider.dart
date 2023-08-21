import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';
import 'package:pif_flutter/ui/employee_details/widget/upload_image_bottom_sheet_options.dart';

final employeeDetailsProvider = StateNotifierProvider.autoDispose<EmployeeDetailsNotifier, EmployeeDetailsState>((ref) {
  return EmployeeDetailsNotifier(ref: ref);
});

class EmployeeDetailsNotifier extends StateNotifier<EmployeeDetailsState> {
  EmployeeDetailsNotifier({required this.ref}) : super(EmployeeDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  final ImagePicker picker = ImagePicker();
  final textfirstNameController = TextEditingController();
  final textlastNameController = TextEditingController();
  String? textJobTitle;
  final textBriefController = TextEditingController();
  final textEmailController = TextEditingController();
  final List<String> jobTitleList = [
    'JobTitle List',
    'sss two',
    'aaa three',
    'sss foure',
    'aaa five',
  ];
  GlobalKey<FormState> formKeyEditProfile = GlobalKey<FormState>();

  void _initData() {
    getUserInformation();
  }

  Future<void> getSpaceAsync(UserModel data) async {
    if (data.allocatedResidentRoomId != null) {
      final result = await DixelsSDK.instance.companyManagementServices.getRoomDetailsByExternalRefCode(
        refCode: data.allocatedResidentRoomId!,
      );
      if (result.isRight()) {
        final item = result.getRight();
        state = state.copyWith(
          spaceImage: item!.imagePrimary!.getImageUrl,
          spaceName: item.name,
        );
      }
    } else {
      if (data.allocatedResidentDeskId != null) {
        final result = await DixelsSDK.instance.companyManagementServices.getSpaceDetailsByExternalRefCode(
          refCode: data.allocatedResidentDeskId!,
        );
        if (result.isRight()) {
          final item = result.getRight();
          state = state.copyWith(
            spaceImage: item!.imagePrimary!.getImageUrl,
            spaceName: item.name,
          );
        }
      }
    }
  }

  void isPreferenceVisible() {
    state = state.copyWith(
      isPreferenceVisible: !state.isPreferenceVisible,
      isGeneralVisible: false,
    );
  }

  void isGeneralVisible() {
    state = state.copyWith(
      isGeneralVisible: !state.isGeneralVisible,
      isPreferenceVisible: false,
    );
  }

  /// Ask for permissions
  Future<void> askPermissions() async {
    final permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      /// if permission is granted than call save to contact method
      await saveToContact();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    final permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      final permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(
        content: Text(
          S.of(AppRouter.navigatorKey.currentContext!).accessContactDenied,
        ),
      );
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(
        content: Text(
          S.of(AppRouter.navigatorKey.currentContext!).enablePermissionsFromSettings,
        ),
      );
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(snackBar);
    }
  }

  Future<void> saveToContact() async {
    final newContact = Contact()
      ..phones = [Phone('+966 4526 345 678')]
      ..emails = [Email('ahmad@pif.gov.sa')];
    await FlutterContacts.openExternalInsert(newContact);
  }

  Future<void> getUserInformation() async {
    final data = await DixelsSDK.instance.userDetails;
    textfirstNameController.text = '${data!.givenName}';
    textlastNameController.text = '${data.familyName}';
    textJobTitle = '${data.jobTitle}';
    textEmailController.text = '${data.emailAddress}';
  }

  void imageSourceBottomSheet(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return UploadImageOptions(
          ctx: ctx,
        );
      },
    );
  }

  Future<void> uploadImage(ImageSource imageSource, BuildContext context) async {
    const maxImageSize = 95000;
    final imageSelected = await picker.pickImage(source: imageSource);
    if (imageSelected != null) {
      final imageSelectedSize = (await imageSelected.readAsBytes()).length;
      if (imageSelectedSize <= maxImageSize) {
        state = state.copyWith(userProfileImage: imageSelected.path);
      } else {
        alertMessage(context: context, errorMessage: 'Image is too large');
      }
    }
  }
}
