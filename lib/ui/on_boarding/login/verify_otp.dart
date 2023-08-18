import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget_with_logo.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/pinput_widget.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';

class VerifyOTP extends ConsumerWidget {
  const VerifyOTP({required this.notifier, super.key});

  final LogInNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(logInProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grayF5,
      appBar: const CustomAppBar(),
      body: BackgroundWidgetWithLogo(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                TileCard(
                  title: S.current.verification,
                  description: S.current.weOfferPasswordExperience,
                ),
                SizedBox(height: 32.h),
                Center(
                  child: PinPutWidget(
                    notifier: notifier,
                    provider: provider,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
