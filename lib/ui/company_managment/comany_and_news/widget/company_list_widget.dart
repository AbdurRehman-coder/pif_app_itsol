import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/widget/company_list_shimmmer.dart';

class CompanyListWidget extends StatelessWidget {
  const CompanyListWidget({
    required this.provider,
    super.key,
  });

  final CompanyAndNewsState provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: provider.companyManagementList.when(
        data: (data) {
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final company = data[index];
              return InkWell(
                onTap: () => AppRouter.pushNamed(Routes.companyDetailsScreen, args: company),
                child: Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        '${Constants.baseUrl}${company.logo!.link!.href ?? ''}',
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(width: 24.w);
            },
            itemCount: data.length,
          );
        },
        error: (_, __) {
          return const SizedBox();
        },
        loading: () {
          return const CompanyListShimmer();
        },
      ),
    );
  }
}
