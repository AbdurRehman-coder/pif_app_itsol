import 'package:flutter/material.dart';
import 'package:pif_flutter/utils/colors.dart';

import 'package:pif_flutter/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.textEditingController,
    required this.labelText,
    this.labelStyle,
    this.onSearch,
    this.onChanged,
    this.filled = true,
    this.isSearch = false,
    super.key,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final bool filled;
  final bool isSearch;
  final void Function()? onSearch;
  final void Function(String)? onChanged;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: lightGrayBgColor,
        filled: filled,
        labelStyle: labelStyle ??
            Style.commonTextStyle(
              color: grayTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: BoxConstraints(maxHeight: 45.h),
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
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.w),
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
        ),
        labelText: labelText,
        suffix:  isSearch
            ? IconButton(
                onPressed: onSearch,
                icon: const Icon(
                  Icons.close,
                  color: primaryColor,
                ),
              )
            : null,
      ),
    );
  }
}
