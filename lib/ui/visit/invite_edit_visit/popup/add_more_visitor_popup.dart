import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/add_more_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/invite_edit_visit_provider.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';

void addMoreVisitorPopup({
  required BuildContext context,
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
          final provider = ref.watch(addMoreVisitorProvider);
          final notifierVisitor = ref.read(inviteVisitorProvider.notifier);
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 100.w,
                          child: const Divider(
                            thickness: 4,
                            color: dividerColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        S.current.addMoreVisitors,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        S.current.visitorOutsideCoBuilder,
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      MarginWidget(
                        horizontal: -16,
                        child: Divider(
                          height: 1.h,
                          color: lineColor,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SecondCustomTextField(
                        textEditingController: provider.emailController,
                        checkEmpty: true,
                        isFocus: true,
                        focusNode: provider.emailFocus,
                        onRemoveFocus: () =>
                            notifierVisitor.checkIfUserIsVisitor(
                          context: context,
                          emailControllerInput: provider.emailController,
                          isFromAddMoreVisitor: true,
                        ),
                        autoFocus: true,
                        hintText: S.current.email,
                        isEmailField: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController:
                                  provider.firstNameController,
                              isFocus: true,
                              hintText: S.current.firstName,
                              checkEmpty: true,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController:
                                  provider.lastNameController,
                              isFocus: true,
                              hintText: S.current.lastName,
                              checkEmpty: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ElevatedButton(
                        onPressed: () => provider.addVisitor(context: context),
                        style: Style.primaryButtonStyle(
                          context: context,
                        ),
                        child: Text(
                          S.current.add,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
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
