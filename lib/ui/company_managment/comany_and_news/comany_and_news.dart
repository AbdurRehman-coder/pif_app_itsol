import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/provider/company_and_news_provider.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/widget/company_list_widget.dart';

class CompanyAndNews extends ConsumerWidget {
  const CompanyAndNews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(companyAndNewsProvider);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          CompanyListWidget(provider: provider),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              height: 50.h,
              thickness: 3.h,
              color: grayBorderColor,
            ),
          ),
          SizedBox(height: 80.h),
          Text(
            'Coming Soon ...',
            style: Style.commonTextStyle(
              color: hintColor,
              fontSize: 25.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
