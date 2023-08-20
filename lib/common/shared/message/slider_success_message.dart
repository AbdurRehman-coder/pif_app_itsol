import 'package:flutter/material.dart';
import 'package:pif_flutter/common/shared/widget/sliding_success_widget.dart';

void showSuccessSliding({
  required BuildContext context,
  required String titleText,
  required void Function() navigateAfterEndTime,
  void Function()? onCancel,
  String? cancelText,
}) {
  final initialBarrierColor = Theme.of(context).dialogBackgroundColor;
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return Center(
        child: SlidingSuccessWidget(
          titleText: titleText,
          navigateAfterEndTime: navigateAfterEndTime,
          onCancel: onCancel,
        ),
      );
    },
  ).then((value) {
    // Reset the barrier color when the slider disappears
    Navigator.of(context).overlay?.setState(() {
      Overlay.of(context)?.context.findRenderObject()?.markNeedsPaint();
    });
  });
}
