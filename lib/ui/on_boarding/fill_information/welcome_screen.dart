import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/fill_personal_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/scan_face.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/bottom_button.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  ConsumerState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
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
    final provider = ref.watch(fillInformationProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (provider.selectedScreen == 0) ...[
              FillPersonalInformation(
                userName: widget.userName,
              ),
            ] else ...[
              const ScanFaceCamera(),
            ],
          ],
        ),
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
      ).visibility(visible:!provider.isDropDownOpen),
    );
  }
}
