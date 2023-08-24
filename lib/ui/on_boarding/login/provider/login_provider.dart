import 'dart:async';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/authentication/login/services/oauth_password_grant_password_less.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  LogInNotifier({required this.ref}) : super(LogInState.initial()) {
    init();
  }

  final Ref ref;
  GlobalKey<FormState> formKeyLogIn = GlobalKey<FormState>();

  late TextEditingController emailController;
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  late Timer timer;

  late TextEditingController pinController;

  void init() {
    emailController = TextEditingController();
    pinController = TextEditingController();
  }

  void startTimerFun() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.timer == 0) {
          timer.cancel();
          state = state.copyWith(timer: state.timer);
        } else {
          var time = state.timer ?? 0;
          state = state.copyWith(timer: --time);
        }
      },
    );
  }

  Future<void> createLogIn({
    required BuildContext context,
    required LogInNotifier notifier,
    bool isResendOTP = false,
  }) async {
    if (formKeyLogIn.currentState!.validate()) {
      final appProgressDialog = AppProgressDialog(context: context);
      await appProgressDialog.start();
      final result = await DixelsSDK.instance.sendOTP(
        baseUrl: Constants.baseUrl,
        auth: OAuth2PasswordGrantPasswordLess(
          email: 'alaa@appswave.io',
          // email: emailController.text,
          clientId: Constants.clientId,
          clientSecret: Constants.clientSecret,
        ),
      );
      await appProgressDialog.stop();
      if (result.isRight()) {
        if (result.getRight()?.message != null) {
          alertMessage(
            errorMessage: result.getLeft().message,
            context: context,
          );
        } else {
          state = state.copyWith(otpLength: result.getRight()?.otpLength);
          state = state.copyWith(expiryTime: result.getRight()?.expiryTime);
          state = state.copyWith(timer: result.getRight()?.expiryTime);
          if (!isResendOTP) {
            await AppRouter.pushNamed(
              Routes.verifyOTPScreen,
              args: notifier,
            );
          }
        }
      } else {
        alertMessage(
          errorMessage: S.current.notAuthorized,
          context: context,
        );
      }
    }
  }

  void resendOTP() {
    state = state.copyWith(timer: state.expiryTime);
    startTimerFun();
  }

  Future<void> verifyOTP({
    required String otpCode,
    required BuildContext context,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.instance.verifyOTP(
      baseUrl: Constants.baseUrl,
      auth: OAuth2PasswordGrantPasswordLess(
        email: kDebugMode ? 'alaa@appswave.io' : emailController.text,
        clientId: Constants.clientId,
        clientSecret: Constants.clientSecret,
        otp: otpCode,
      ),
    );
    await appProgressDialog.stop();
    if (result.isRight()) {
      if (result.getRight()?.refreshToken == null) {
        alertMessage(
          errorMessage: result.getRight()?.message ?? '',
          context: context,
        );
      } else {
        await goToWelcomeScreen();
      }
    } else {
      alertMessage(
        errorMessage: result.getLeft().message,
        context: context,
      );
    }
  }

  Future<void> goToWelcomeScreen() async {
    pinController.clear();
    emailController.clear();
    final data = await DixelsSDK.instance.userDetails;
    if (data?.customFields
            ?.where((element) => element.name == 'isVerified')
            .firstOrNull
            ?.customValue
            .data
            .toString()
            .toLowerCase() ==
        'true') {
      await AppRouter.startNewRoute(
        Routes.dashboardScreen,
      );
    } else {
      await AppRouter.pushReplacement(
        Routes.welcomeScreen,
        args: data?.givenName,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
