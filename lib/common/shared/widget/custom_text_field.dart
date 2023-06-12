import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.textEditingController,
    this.labelText,
    this.hintText,
    this.labelStyle,
    this.onSearch,
    this.focusNode,
    this.onChanged,
    this.filled = true,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.checkEmpty = false,
    this.decoration,
    this.validateEmptyString,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.only(left: 12, right: 12, top: 20),
    super.key,
  });

  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final bool filled;
  final bool enabled;
  final int? maxLength;
  final int? maxLines;
  final bool checkEmpty;
  final String? validateEmptyString;
  final void Function()? onSearch;
  final void Function(String)? onChanged;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      validator: (val) {
        if (checkEmpty) {
          if (val!.isEmpty) {
            return validateEmptyString ?? S.of(context).thisFieldIsRequired;
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      maxLength: maxLength,
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLines,
      decoration: decoration ??
          InputDecoration(
            fillColor: lightGrayBgColor,
            contentPadding: contentPadding,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              borderSide: BorderSide(color: borderColor, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.w),
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              borderSide: BorderSide(color: redColor, width: 1.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              borderSide: BorderSide(color: redColor, width: 1.w),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.w),
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
            filled: filled,
            hintText: hintText,
            hintStyle: Style.commonTextStyle(
              color: grayTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: labelStyle ??
                Style.commonTextStyle(
                  color: grayTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
            labelText: labelText,
          ),
    );
  }
}
