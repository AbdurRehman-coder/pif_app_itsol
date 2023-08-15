import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';

class CheckPrivacy extends ConsumerWidget {
  const CheckPrivacy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(fillInformationProvider);
    final notifier = ref.read(fillInformationProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: provider.acceptTermsAndCondition,
              onChanged: (value) =>
                  notifier.updateTermsAndCondition(termsAndCondition: value!),
            ),
            InkWell(
              onTap: () =>
                  AppRouter.pushNamed(Routes.privacyScreen, args: false),
              child: RichText(
                text: TextSpan(
                  text: S.current.IAgreeToThe,
                  style: Style.commonTextStyle(
                    color: black700,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: S.current.TermsAndConditions,
                      style: Style.commonTextStyle(
                        color: primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: provider.acceptNDA,
              onChanged: (value) => notifier.updateNDA(nda: value!),
            ),
            InkWell(
              onTap: () =>
                  AppRouter.pushNamed(Routes.privacyScreen, args: true),
              child: RichText(
                text: TextSpan(
                  text: S.current.IAgreeToTheCoBuilder,
                  style: Style.commonTextStyle(
                    color: black700,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: S.current.NDU,
                      style: Style.commonTextStyle(
                        color: primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
