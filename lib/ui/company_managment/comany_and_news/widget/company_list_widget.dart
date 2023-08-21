import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/provider/company_and_news_provider.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/widget/company_list_shimmmer.dart';

class CompanyListWidget extends StatelessWidget {
  const CompanyListWidget({
    required this.provider,
    required this.notifier,
    super.key,
  });

  final CompanyAndNewsState provider;
  final CompanyAndNewsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: SizedBox(
        height: 80.h,
        child: provider.companyManagementList.when(
          data: (data) {
            return ListView.separated(
              shrinkWrap: true,
              controller: notifier.scrollController,
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                if (data.length == index) {
                  return Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ).visibility(visible: provider.isLoading);
                }
                final company = data[index];

                return InkWell(
                  onTap: () => AppRouter.pushNamed(Routes.companyDetailsScreen, args: company),
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          whiteColor.withOpacity(0.32),
                          whiteColor.withOpacity(0.32),
                        ],
                      ),
                      backgroundBlendMode: BlendMode.overlay,
                      border: Border.all(color: whiteColor),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: '${Constants.baseUrl}${company.logo!.link!.href ?? ''}',
                        placeholder: (context, url) => Image.asset(
                          Assets.placeHolder,
                          fit: BoxFit.fill,
                          height: 80.h,
                          width: 80.w,
                        ),
                        errorWidget: (context, url, error) => Image.network(
                          'https://picsum.photos/80/80',
                          fit: BoxFit.fill,
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(width: 24.w);
              },
              itemCount: data.length + 1,
            );
          },
          error: (_, __) {
            return const SizedBox();
          },
          loading: () {
            return const CompanyListShimmer();
          },
        ),
      ),
    );
  }
}
