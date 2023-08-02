import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/booking/provider/add_visitor_provider.dart';

void addVisitorBottomSheet({
  required BuildContext context,
  required BookingState provider,
  required BookingNotifier notifier,
}) {
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final notifier = ref.read(addVisitorProvider.notifier);
          final provider = ref.watch(addVisitorProvider);
          return Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: 40.h,
            ),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Form(
                  key: notifier.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 5.h,
                        width: 67.w,
                        decoration: BoxDecoration(
                          color: dividerColor,
                          borderRadius: BorderRadius.circular(6.h),
                        ),
                      ).toCenter(),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        S.of(context).addNewGuest,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        S.of(context).guestOutSideCoBuilder,
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      SecondCustomTextField(
                        textEditingController: notifier.visitorEmailController,
                        focusNode: notifier.emailFocus,
                        borderRadius: 6.r,
                        autoFocus: true,
                        fillColor: whiteColor,
                        checkEmpty: true,
                        isEmailField: true,
                        isFocus: provider.isFocusEmail,
                        hintText: S.current.str_email,
                        keyboardType: TextInputType.emailAddress,
                        contentPadding: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController: notifier.visitorFirstNameController,
                              focusNode: notifier.firstNameFocus,
                              checkEmpty: true,
                              borderRadius: 6.r,
                              fillColor: whiteColor,
                              isFocus: provider.isFocusFirstName,
                              hintText: S.current.firstName,
                              contentPadding: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController: notifier.visitorLastNameController,
                              focusNode: notifier.lastNameFocus,
                              checkEmpty: true,
                              borderRadius: 6.r,
                              fillColor: whiteColor,
                              isFocus: provider.isFocusLastName,
                              hintText: S.current.lastName,
                              textFieldBorderColor: textFieldBorderColor,
                              contentPadding: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
                              hintFontSize: 14.sp,
                              hintTextColor: blackColorWith900.withOpacity(0.45),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          notifier.inviteAsync(context: context);
                        },
                        style: Style.primaryButtonStyle(
                          context: context,
                        ),
                        child: Text(
                          S.of(context).invite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
