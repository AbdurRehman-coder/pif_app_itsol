import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/company_managment/company_details/index.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';

final employeeDetailsProvider = StateNotifierProvider.autoDispose<
    EmployeeDetailsNotifier, EmployeeDetailsState>((ref) {
  return EmployeeDetailsNotifier(ref: ref);
});

class EmployeeDetailsNotifier extends StateNotifier<EmployeeDetailsState> {
  EmployeeDetailsNotifier({required this.ref})
      : super(EmployeeDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  final lstService = <CompanyDetailsModel>[];
  final lstEmployee = <EmployeeDetailsModel>[];

  void _initData() {
    lstService.add(
      CompanyDetailsModel(
        id: 0,
        companyService: 'Photography',
        selected: false,
      ),
    );
    lstService.add(
      CompanyDetailsModel(
        id: 1,
        companyService: 'Technology',
        selected: false,
      ),
    );
    lstService.add(
      CompanyDetailsModel(
        id: 2,
        companyService: 'Technology',
        selected: false,
      ),
    );
    for (var i = 0; i < 5; i++) {
      lstEmployee.add(
        EmployeeDetailsModel(
          address: 'Al Multaqa 304',
          streetName: 'Incubated since 2022',
        ),
      );
    }

    state = state.copyWith(lstService: lstService, lstEmployee: lstEmployee);
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
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      /// if permission is granted than call save to contact method
      await saveToContact();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
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
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(
        content: Text(
          S
              .of(AppRouter.navigatorKey.currentContext!)
              .enablePermissionsFromSettings,
        ),
      );
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }

  Future<void> saveToContact() async {
    final newContact = Contact()
      ..phones = [Phone('+966 4526 345 678')]
      ..emails = [Email('ahmad@pif.gov.sa')];
    await FlutterContacts.openExternalInsert(newContact);
  }
}
