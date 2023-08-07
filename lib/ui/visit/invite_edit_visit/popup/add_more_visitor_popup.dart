import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/add_more_visitor_provider.dart';
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
          final notifier = ref.watch(addMoreVisitorProvider);
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Form(
                  key: notifier.formKey,
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
                        S.of(context).addMoreVisitors,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        S.of(context).visitorOutsideCoBuilder,
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
                      Row(
                        children: [
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController:
                                  notifier.firstNameController,
                              autoFocus: true,
                              checkEmpty: true,
                              hintText: S.current.firstName,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SecondCustomTextField(
                              textEditingController:
                                  notifier.lastNameController,
                              checkEmpty: true,
                              hintText: S.current.lastName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomTextField(
                        textEditingController: notifier.emailController,
                        checkEmpty: true,
                        hintText: S.current.email,
                        isEmailField: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ElevatedButton(
                        onPressed: () => notifier.addVisitor(context: context),
                        style: Style.primaryButtonStyle(
                          context: context,
                        ),
                        child: Text(
                          S.of(context).add,
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
