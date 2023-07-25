import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/login/state/login_state.dart';

final logInProvider =
    StateNotifierProvider.autoDispose<LogInNotifier, LogInState>((ref) {
  return LogInNotifier(ref: ref);
});

class LogInNotifier extends StateNotifier<LogInState> {
  LogInNotifier({required this.ref}) : super(LogInState.initial());

  final Ref ref;

  GlobalKey<FormState> formKeyLogIn = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final pinController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Future<void> createLogIn({required BuildContext context}) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.instance.initialize(
      baseUrl: Constants.baseUrl,
      auth: OAuth2PasswordGrant(
        username: 'mwafeeq@appswave.io',
        // username: emailController.text,
        password: 'Mwni127199411',
        // password: passwordController.text,
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

  void goToOTP() {
    if (formKeyLogIn.currentState!.validate()) {
      AppRouter.pushNamed(Routes.verifyOTPScreen);
    }
  }

  void goToWelcomeScreen() {
    pinController.clear();
    emailController.clear();
    AppRouter.pushNamedAndRemoveUntil(
      Routes.welcomeScreen,
      Routes.welcomeScreen,
      args: 'Obaida',
    );
  }
}
