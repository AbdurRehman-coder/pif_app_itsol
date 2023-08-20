import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/fill_all_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  ConsumerState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(fillInformationProvider);
    return Scaffold(
      body: Center(
        child: Text(
          '${S.current.hi} ${widget.userName}!',
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateUser({required BuildContext context}) async {
    await Navigator.of(context).pushAndRemoveUntil(
      PageAnimationTransition(
        page: FillAllInformationScreen(
          userName: widget.userName,
        ),
        pageAnimationType: RightToLeftFadedTransition(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => _navigateUser(context: context),
    );
  }
}
