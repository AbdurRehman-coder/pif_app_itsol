import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';

class SecondCustomTextField extends StatefulWidget {
  const SecondCustomTextField({
    required this.textEditingController,
    this.onTap,
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
    this.contentPadding,
    this.onRemoveFocus,
    this.isEmailField = false,
    this.keyboardType = TextInputType.text,
    this.isFocus = false,
    this.autoFocus = false,
    this.textFieldBorderColor = grayBorderColor,
    this.borderRadius = 6,
    this.hintFontSize = 14,
    this.hintTextColor = hintColor,
    this.isDateAndTime = false,
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
  final void Function()? onRemoveFocus;
  final void Function(String)? onChanged;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final TextStyle? style;
  final Color? fillColor;
  final bool isEmailField;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool isFocus;
  final Color textFieldBorderColor;
  final void Function()? onTap;
  final bool autoFocus;
  final double borderRadius;
  final double hintFontSize;
  final Color hintTextColor;
  final EdgeInsets? contentPadding;
  final bool? isDateAndTime;

  @override
  State<SecondCustomTextField> createState() => _SecondCustomTextFieldState();
}

class _SecondCustomTextFieldState extends State<SecondCustomTextField> {
  @override
  Widget build(BuildContext context) {
    final isEnableFiled =
        widget.focusNode == null ? widget.isFocus : widget.focusNode?.hasFocus;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: widget.onTap,
              style: widget.style ??
                  Style.commonTextStyle(
                    color: blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
              obscureText: widget.obscureText,
              onChanged: (val) {
                setState(() {});
                widget.onChanged?.call(val);
              },
              controller: widget.textEditingController,
              keyboardType: widget.keyboardType,
              validator: (val) {
                if (widget.checkEmpty) {
                  if (val!.isEmpty) {
                    return widget.validateEmptyString ??
                        S.of(context).thisFieldIsRequired;
                  }
                  if (widget.isEmailField && !val.isValidEmail()) {
                    return S.of(context).enterValidEmail;
                  } else {
                    return null;
                  }
                } else {
                  return null;
                }
              },
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              textAlignVertical: widget.textEditingController.text.isNotEmpty
                  ? TextAlignVertical.bottom
                  : null,
              focusNode: widget.focusNode,
              maxLines: widget.maxLines,
              onEditingComplete: widget.onEditingComplete,
              autofocus: widget.autoFocus,
              decoration: widget.decoration ??
                  InputDecoration(
                    fillColor: widget.fillColor ?? whiteColor,
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.only(
                          left: 12.w,
                          right: 12.w,
                          top: 25.h,
                          bottom: widget.prefixIcon != null ||
                                  widget.suffixIcon != null
                              ? 5.h
                              : 6.h,
                        ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                      borderSide: BorderSide(
                        color: isEnableFiled! && widget.isDateAndTime!
                            ? primaryLightColor
                            : isEnableFiled
                                ? grayTextColor
                                : widget.textFieldBorderColor,
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                      borderSide:
                          BorderSide(color: grayBorderColor, width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isEnableFiled
                            ? primaryColor
                            : widget.textFieldBorderColor,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                      borderSide: BorderSide(color: redColor, width: 1.w),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                      borderSide: BorderSide(color: redColor, width: 1.w),
                    ),
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: widget.textEditingController.text.isEmpty
                                  ? 0
                                  : 20.h,
                            ),
                            child: widget.prefixIcon,
                          )
                        : widget.prefixIcon,
                    counterText: '',
                    floatingLabelStyle: Style.commonTextStyle(
                      color: grayTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.textFieldBorderColor,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.r),
                      ),
                    ),
                    filled: widget.filled,
                    hintText: widget.hintText,
                    hintStyle: Style.commonTextStyle(
                      color: widget.hintTextColor,
                      fontSize: widget.hintFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: widget.labelStyle ??
                        Style.commonTextStyle(
                          color: hintColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    labelText: widget.labelText,
                  ),
            ),
            if (widget.maxLength != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: Text(
                  '${S.current.maxLengthOf} ${widget.maxLength!} ${S.current.character}',
                  style: Style.commonTextStyle(
                    color: darkBorderColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (widget.textEditingController.text.isNotEmpty) ...[
          Positioned(
            top: 5.h,
            left: 10.w,
            child: Text(
              widget.hintText ?? '',
              style: Style.commonTextStyle(
                color: widget.hintTextColor,
                fontSize: widget.hintFontSize - 2,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() {
        if (!widget.focusNode!.hasFocus) {
          widget.onRemoveFocus?.call();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode != null) {
      widget.focusNode!.removeListener(() {});
    }
  }
}
