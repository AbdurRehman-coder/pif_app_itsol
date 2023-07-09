import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';

final logInProvider = Provider.autoDispose<LogInNotifier>((ref) {
  return LogInNotifier();
});

class LogInNotifier {
  LogInNotifier();

  final formKeyLogIn = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // void init() {
  //   emailController.text = Constants.username;
  //   passwordController.text = Constants.password;
  // }

  Future<void> createLogIn({required BuildContext context}) async {
    if (formKeyLogIn.currentState!.validate()) {
      final appProgressDialog = AppProgressDialog(context: context);
      await appProgressDialog.start();
      final result = await DixelsSDK.instance.initialize(
        baseUrl: Constants.baseUrl,
        auth: OAuth2PasswordGrant(
          // username: 'mwafeeq@appswave.io',
          username: emailController.text,
          // password: 'Mwni127199411',
          password: passwordController.text,
          clientId: Constants.clientId,
          clientSecret: Constants.clientSecret,
        ),
      );
      await appProgressDialog.stop();
      if (result) {
        await AppRouter.pushReplacement(Routes.dashboardScreen);
      } else {
        alertMessage(
          errorMessage: 'User not found',
          context: context,
        );
      }
    }
  }
}
