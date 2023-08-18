import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';

class EditProfileImage extends ConsumerWidget {
  const EditProfileImage({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final EmployeeDetailsNotifier notifier;
  final EmployeeDetailsState provider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        notifier.imageSourceBottomSheet(
          context,
        );
      },
      child: Stack(
        children: [
          Container(
            height: 80.r,
            width: 80.r,
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: 3.r,
                  color: goldenColor,
                ),
              ),
            ),
            child: provider.userProfileImage == ''
                ? ClipOval(
                    child: Image.asset(
                      Assets.placeHolder,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(provider.userProfileImage)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 51.h,
              left: 50.w,
            ),
            child: Container(
              height: 32.r,
              width: 32.r,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                size: 16,
                color: whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
