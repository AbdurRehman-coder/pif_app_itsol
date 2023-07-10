import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/extensions/file_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/image_loader.dart';

class ImageSelected extends StatelessWidget {
  const ImageSelected({
    required this.imageFile,
    super.key,
  });

  final XFile imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:100.h,
      width: 300.w,
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
    );
  }
}
