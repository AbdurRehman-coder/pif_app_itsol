import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({
    required this.fromNda,
    this.isDashboard = false,
    super.key,
  });

  final bool fromNda;
  final bool isDashboard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fillInfoProvider = ref.watch(fillInformationProvider);
    final provider = ref.watch(dashboardProvider);

    final htmlTextNDA = isDashboard
        ? provider.structureContent.value?.contentFields
            ?.where((element) => element.name == 'nda')
            .firstOrNull
            ?.contentFieldValue
            ?.data
        : fillInfoProvider.contentModel?.value?.contentFields
            ?.where((element) => element.name == 'nda')
            .firstOrNull
            ?.contentFieldValue
            ?.data;
    final htmlTextTerms = isDashboard
        ? provider.structureContent.value?.contentFields
            ?.where((element) => element.name == 'termsAndConditions')
            .firstOrNull
            ?.contentFieldValue
            ?.data
        : fillInfoProvider.contentModel?.value?.contentFields
            ?.where((element) => element.name == 'termsAndConditions')
            .firstOrNull
            ?.contentFieldValue
            ?.data;
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      appBar: CustomAppBar(
        title: fromNda ? S.current.NDU : S.current.termsOfService,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: HtmlWidget(
          fromNda ? (htmlTextNDA ?? '') : (htmlTextTerms ?? ''),
        ),
      ),
    );
  }
}
