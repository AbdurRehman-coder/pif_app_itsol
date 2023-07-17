import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/fill_personal_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/scan_face.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/personal_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/bottom_button.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animateButton;

  @override
  void initState() {
    super.initState();
    animateButton = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 3500), () {
      animateButton.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();

    animateButton.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: AppRouter.pop,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 22,
              ),
            ),
          ),
        ),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final provider = ref.watch(fillInformationProvider);
          return BackgroundWidget(
            child: provider.selectedScreen == 0
                ? FillPersonalInformation(
                    userName: widget.userName,
                  )
                : const ScanFace(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FadeTransition(
        opacity: Tween(begin: 0.0, end: 0.8).animate(
          CurvedAnimation(
            parent: animateButton,
            curve: Curves.easeInToLinear,
          ),
        ),
        child: const BottomButton(),
      ),
    );
  }
}