import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
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
    final borderColorByDefault = borderColor.withOpacity(0.5);
    final borderRadius = BorderRadius.all(
      Radius.circular(30.r),
    );
    final isEnableFiled = focusNode == null ? isFocus : focusNode?.hasFocus;
    return SizedBox(
      height: 40.h,
      child: TextFormField(
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
        decoration: InputDecoration(
          fillColor: fillColor ?? lightGrayBgColor,
          contentPadding: contentPadding,
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: isEnableFiled! ? primaryColor : whiteColor,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: borderColorByDefault, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isEnableFiled ? primaryColor : borderColorByDefault,
              width: 1.w,
            ),
            borderRadius: borderRadius,
          ),
          errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: redColor, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: redColor, width: 1.w),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: const Icon(
            Icons.search,
            color: darkBorderColor,
            size: 25,
          ),
          counterText: '',
          floatingLabelStyle: Style.commonTextStyle(
            color: isEnableFiled ? primaryColor : grayTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColorByDefault, width: 1.w),
            borderRadius: borderRadius,
          ),
          filled: filled,
          hintText: hintText,
          hintStyle: Style.commonTextStyle(
            color: hintColor,
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
      ),
    );
  }
}
