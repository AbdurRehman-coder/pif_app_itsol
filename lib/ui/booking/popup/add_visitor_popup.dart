import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/booking/provider/add_visitor_provider.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';

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
              top: 24.h,
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
                      Row(
                        children: [
                          Text(
                            S.of(context).inviteVisitor,
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: AppRouter.pop,
                            icon: SvgPicture.asset(
                              Assets.cancelBtn,
                            ),
                          )
                        ],
                      ),
                      Text(
                        S.of(context).visitorOutsideCoBuilder,
                        style: Style.commonTextStyle(
                          color: silverTextColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      MarginWidget(
                        horizontal: -16,
                        child: Container(
                          height: 1.h,
                          color: lineColor,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              textEditingController: notifier.visitorFirstNameController,
                              focusNode: notifier.firstNameFocus,
                              checkEmpty: true,
                              autoFocus: true,
                              isFocus: provider.isFocusFirstName,
                              labelText: S.current.firstName,
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: CustomTextField(
                              textEditingController: notifier.visitorLastNameController,
                              focusNode: notifier.lastNameFocus,
                              checkEmpty: true,
                              isFocus: provider.isFocusLastName,
                              labelText: S.current.lastName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextField(
                        textEditingController: notifier.visitorEmailController,
                        focusNode: notifier.emailFocus,
                        checkEmpty: true,
                        isEmailField: true,
                        isFocus: provider.isFocusEmail,
                        labelText: S.current.visitorEmail,
                        prefixIcon: SvgPicture.asset(
                          Assets.email,
                          fit: BoxFit.scaleDown,
                        ),
                        keyboardType: TextInputType.emailAddress,
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
