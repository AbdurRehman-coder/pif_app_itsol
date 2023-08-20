import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class SlidingSuccessWidget extends StatefulWidget {
  SlidingSuccessWidget({
    required this.titleText,
    required this.navigateAfterEndTime,
    this.onCancel,
    this.cancelText,
  });
  final String titleText;
  final void Function() navigateAfterEndTime;
  void Function()? onCancel;
  final String? cancelText;

  @override
  _SlidingSuccessWidgetState createState() => _SlidingSuccessWidgetState();
}

class _SlidingSuccessWidgetState extends State<SlidingSuccessWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _animationCompleted = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ), // Change transition duration to 300 milliseconds
    );
    _animationController.forward().whenComplete(() {
      _timer = Timer(const Duration(seconds: 3), () {
        _animationController.reverse().whenComplete(() {
          _timer?.cancel();
          AppRouter.pop();
          widget.navigateAfterEndTime();
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 120.h),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              color: darkPrimaryColor,
              height: 70.h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        widget.titleText,
                        style: TextStyle(
                          color: grayC0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _animationController.reverse().whenComplete(() {
                        _timer?.cancel();
                        widget.onCancel?.call();
                      });
                    },
                    child: Text(
                      widget.cancelText ?? S.of(context).cancel,
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
