import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';
import 'package:pif_flutter/ui/employee_details/widget/edit_profile_image.dart';

class EmployeeProfileEditPage extends ConsumerWidget {
  const EmployeeProfileEditPage({
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
                ),
                SizedBox(
                  height: 16.h,
                ),
                SecondCustomTextField(
                  textEditingController: notifier.textBriefController,
                  fillColor: whiteColor,
                  hintText: S.current.breif,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 16.h,
                ),
                DropDownSearchApp(
                  items: notifier.jobTitleList,
                  withSearch: false,
                  vDropdownSearchController: VDropdownSearchController(),
                  hintText: 'Country',
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
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (notifier.formKeyEditProfile.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      child: Text(
                        'Save',
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
