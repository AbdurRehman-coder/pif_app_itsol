import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/index.dart';

class ImageSelected extends StatelessWidget {
  const ImageSelected({
    required this.imageFile,
    required this.onDeleteFile,
    super.key,
  });

  final XFile imageFile;
  final void Function()? onDeleteFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
            image: DecorationImage(
              image: FileImage(
                File(
                  imageFile.path,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned  (
          top: 4.h,
          right: 4.w,
          child: InkWell(
            onTap: onDeleteFile,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: inactiveTrackColor,
              ),
              child: const Icon(
                Icons.close,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
