import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/terms_condition_shimmer.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({required this.fromNda, super.key});

  final bool fromNda;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(fillInformationProvider);
    final htmlTextNDA = provider.contentModel!.value?.contentFields
        ?.where((element) => element.name == 'nda')
        .firstOrNull
        ?.contentFieldValue
        ?.data;
    final htmlTextTerms = provider.contentModel!.value?.contentFields
        ?.where((element) => element.name == 'termsAndConditions')
        .firstOrNull
        ?.contentFieldValue
        ?.data;
    print('html text:: $htmlTextNDA $htmlTextTerms');
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      appBar: CustomAppBar(
        title: fromNda ? S.current.NDU : S.current.termsOfService,
      ),
      body: htmlTextNDA == null && htmlTextTerms == null
          ? const TermsConditionShimmerWidget()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: HtmlWidget(
                fromNda ? (htmlTextNDA ?? '') : (htmlTextTerms ?? ''),
              ),
            ),
    );
  }
}
