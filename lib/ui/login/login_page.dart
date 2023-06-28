import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/login/provider/login_provider.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(logInProvider);
    return Scaffold(
      backgroundColor: grayF5,
      body: Form(
        key: notifier.formKeyLogIn,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Center(
                  child: Image.asset(
                    Assets.logo,
                    height: 100.h,
                    width: 100.w,
                  ),
                ),
                SizedBox(height: 100.h),
                CustomTextField(
                  textEditingController: notifier.emailController,
                  labelText: S.of(context).email,
                  isEmailField: true,
                  checkEmpty: true,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  textEditingController: notifier.passwordController,
                  labelText: S.of(context).password,
                  checkEmpty: true,
                  obscureText: true,
                ),
                SizedBox(height: 60.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    onPressed: () => notifier.createLogIn(context: context),
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
    );
  }
}
