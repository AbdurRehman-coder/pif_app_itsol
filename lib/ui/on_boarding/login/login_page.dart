import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/empty_image.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(logInProvider.notifier);
    final provider = ref.watch(logInProvider);
    return Scaffold(
      backgroundColor: grayF5,
      body: BackgroundWidget(
        child: SafeArea(
          child: Form(
            key: notifier.formKeyLogIn,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(S.current.lang),
                            SizedBox(width: 4.w),
                            const Icon(
                              Icons.language,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    TileCard(
                      title: S.current.login,
                      description: S.current.weOfferPasswordExperience,
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: notifier.updateImage,
                      child: provider.imageFile == null
                          ? const EmptyImage()
                          : Image.file(
                              File(
                                provider.imageFile!.path,
                              ),
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.fill,
                            ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      textEditingController: notifier.emailController,
                      labelText: S.of(context).email,
                      isEmailField: true,
                      checkEmpty: true,
                    ),
                    SizedBox(height: 60.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        onPressed: notifier.goToOTP,
                        child: Text(
                          S.current.login,
                          style: Style.commonTextStyle(
                            color: whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
