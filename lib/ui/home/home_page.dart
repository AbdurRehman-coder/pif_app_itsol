import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/widget/banner_view.dart';
import 'package:pif_flutter/ui/home/widget/category_list_view.dart';
import 'package:pif_flutter/utils/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              onTap: () {
                AppRouter.pushNamed(Routes.companyServiceScreen);
              },
              child: Image.asset(
                Assets.homeWidget,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            const BannerView(),
            SizedBox(
              height: 40.h,
            ),
            const CategoryListView(),
          ],
        ),
      ),
    );
  }
}
