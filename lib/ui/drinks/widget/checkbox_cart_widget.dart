import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CustomCheckBoxWithText extends StatefulWidget {
  final bool isChecked;
  final String text;
  final void Function(bool?) onChanged;

  CustomCheckBoxWithText({
    required this.isChecked,
    required this.text,
    required this.onChanged,
  });

  @override
  _CustomCheckBoxWithTextState createState() => _CustomCheckBoxWithTextState();
}

class _CustomCheckBoxWithTextState extends State<CustomCheckBoxWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 40.h,
          width: 20.w,
          child: Checkbox(
            value: widget.isChecked,
            onChanged: widget.onChanged,
            activeColor: primaryDarkColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5, // line-height
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}
