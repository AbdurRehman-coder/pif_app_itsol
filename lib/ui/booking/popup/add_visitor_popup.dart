import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';
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
                      child: TextField(
                        controller: notifier.visitorFirstNameController,
                        focusNode: notifier.firstNameFocus,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: lightGrayBgColor,
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                          ),
                          labelStyle: Style.commonTextStyle(
                            color: notifier.firstNameFocus.hasFocus ? primaryColor : grayTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          constraints: BoxConstraints(maxHeight: 50.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.firstNameFocus.hasFocus ? primaryColor : borderColor, width: 1.w),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                          ),
                          labelText: S.of(context).firstName,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: TextField(
                        controller: notifier.visitorLastNameController,
                        focusNode: notifier.lastNameFocus,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: lightGrayBgColor,
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                          ),
                          labelStyle: Style.commonTextStyle(
                            color: notifier.lastNameFocus.hasFocus ? primaryColor : grayTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          constraints: BoxConstraints(maxHeight: 50.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.lastNameFocus.hasFocus ? primaryColor : borderColor, width: 1.w),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor, width: 1.w),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.r),
                            ),
                          ),
                          labelText: S.of(context).lastName,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                TextField(
                  controller: notifier.visitorEmailController,
                  focusNode: notifier.emailFocus,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: lightGrayBgColor,
                    filled: true,
                    prefixIcon: SvgPicture.asset(
                      Assets.email,
                      fit: BoxFit.scaleDown,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.r),
                      ),
                      borderSide: BorderSide(color: borderColor, width: 1.w),
                    ),
                    labelStyle: Style.commonTextStyle(
                      color: notifier.emailFocus.hasFocus ? primaryColor : grayTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    constraints: BoxConstraints(maxHeight: 50.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.r),
                      ),
                      borderSide: BorderSide(color: borderColor, width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: notifier.emailFocus.hasFocus ? primaryColor : borderColor, width: 1.w),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.r),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor, width: 1.w),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.r),
                      ),
                    ),
                    labelText: S.of(context).visitorEmail,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  provider.errorMessage,
                  style: Style.commonTextStyle(
                    color: redColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30.h,
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
      );
    },
  );
}
