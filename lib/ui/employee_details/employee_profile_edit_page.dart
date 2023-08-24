import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';
import 'package:pif_flutter/ui/employee_details/widget/edit_profile_image.dart';

class EmployeeProfileEditPage extends ConsumerWidget {
  EmployeeProfileEditPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(employeeDetailsProvider.notifier);
    final provider = ref.watch(employeeDetailsProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: S.current.editProfile,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Form(
          key: notifier.formKeyEditProfile,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditProfileImage(
                  notifier: notifier,
                  provider: provider,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SecondCustomTextField(
                        textEditingController: notifier.textfirstNameController,
                        fillColor: whiteColor,
                        hintText: S.current.firstName,
                        checkEmpty: true,
                        onChanged: (val) {
                          notifier.updateDisableButton(isChanged: true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: SecondCustomTextField(
                        textEditingController: notifier.textlastNameController,
                        fillColor: whiteColor,
                        hintText: S.current.lastName,
                        checkEmpty: true,
                        onChanged: (val) {
                        notifier.updateDisableButton(isChanged: true);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                DropDownSearchApp(
                  items: notifier.jobTitleList,
                  withSearch: false,
                  vDropdownSearchController: VDropdownSearchController(),
                  hintText: S.current.jobTitle,
                  selectedItem: notifier.textJobTitle,
                  dropDownBorderRadius: BorderRadius.circular(6.r),
                  onChanged: (val) {
                  notifier.updateDisableButton(isChanged: true);
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                SecondCustomTextField(
                  textEditingController: notifier.textBriefController,
                  fillColor: whiteColor,
                  hintText: S.current.breif,
                  maxLines: 5,
                  onChanged: (val) {
                  notifier.updateDisableButton(isChanged: true);
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                DropDownSearchApp(
                  items: notifier.jobTitleList,
                  withSearch: false,
                  vDropdownSearchController: VDropdownSearchController(),
                  hintText: 'Country',
                  dropDownBorderRadius: BorderRadius.circular(6.r),
                  onChanged: (val) {
                  notifier.updateDisableButton(isChanged: true);
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                SecondCustomTextField(
                  textEditingController: notifier.textEmailController,
                  isEmailField: true,
                  enabled: false,
                  fillColor: grayEB,
                  keyboardType: TextInputType.emailAddress,
                  hintText: S.current.email,
                  onChanged: (val) {
                  notifier.updateDisableButton(isChanged: true);
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
        color: expireBgColor,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: 
          !provider.isDisable!
              ? () {
                 if (notifier.formKeyEditProfile.currentState!.validate())
                  {
                  notifier.updateInformationUser(context: context);
                  notifier.isUpdateImage = false;
                  notifier.updateDisableButton();
                }}
              : null,
          style: Style.primaryButtonStyleSecond(
            context: context,
            primaryColor: provider.isDisable!
                ? primaryDisabledColor
                : primaryColor,
          ),
          child: Text(
            S.current.save,
          ),
        ),
      ),
    );
  }
}
