import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/fill_personal_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/scan_face.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/bottom_button.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget_with_logo.dart';

class FillAllInformationScreen extends ConsumerStatefulWidget {
  const FillAllInformationScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  ConsumerState createState() => _FillAllInformationScreenState();
}

class _FillAllInformationScreenState
    extends ConsumerState<FillAllInformationScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(fillInformationProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: '',
      ),
      body: BackgroundWidgetWithLogo(
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
      floatingActionButton: const BottomButton(),
    );
  }
}
