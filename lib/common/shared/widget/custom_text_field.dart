import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
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
    this.obscureText = false,
    this.decoration,
    this.validateEmptyString,
    this.prefixIcon,
    this.onEditingComplete,
    this.suffixIcon,
    this.style,
    this.fillColor,
    this.contentPadding = const EdgeInsets.only(left: 12, right: 12, top: 20),
    this.isEmailField = false,
    this.keyboardType = TextInputType.text,
    this.isFocus = false,
    this.autoFocus = false,
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
  final void Function()? onEditingComplete;
  final void Function()? onSearch;
  final void Function(String)? onChanged;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final TextStyle? style;
  final Color? fillColor;
  final bool isEmailField;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool isFocus;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final isEnableFiled = focusNode == null ? isFocus : focusNode?.hasFocus;
    return TextFormField(
      style: style,
      obscureText: obscureText,
      onChanged: onChanged,
      controller: textEditingController,
      keyboardType: keyboardType,
      validator: (val) {
        if (checkEmpty) {
          if (val!.isEmpty) {
            return validateEmptyString ?? S.of(context).thisFieldIsRequired;
          }
          if (isEmailField && !val.isValidEmail()) {
            return S.of(context).enterValidEmail;
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
      onEditingComplete: onEditingComplete,
      autofocus: autoFocus,
      decoration: decoration ??
          InputDecoration(
            fillColor: fillColor ?? lightGrayBgColor,
            contentPadding: contentPadding,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              borderSide: BorderSide(color: isEnableFiled! ? primaryColor : borderColor, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              borderSide: BorderSide(color: borderColor, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: isEnableFiled ? primaryColor : borderColor, width: 1.w),
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
            floatingLabelStyle: Style.commonTextStyle(
              color: isEnableFiled ? primaryColor : grayTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
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
