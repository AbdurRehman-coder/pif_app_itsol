import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/animations/rotate_animation_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/welcome_screen.dart';

class HiScreen extends ConsumerStatefulWidget {
  const HiScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  ConsumerState createState() => _HiScreenState();
}

class _HiScreenState extends ConsumerState<HiScreen> {
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
    await Navigator.of(context).push(
      PageAnimationTransition(
        page: WelcomeScreen(
          userName: widget.userName,
        ),
        pageAnimationType: RightToLeftFadedTransition(),
      ),
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
