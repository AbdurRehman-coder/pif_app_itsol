import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/home/widget/read_more/congrates_text.dart';
import 'package:pif_flutter/ui/home/widget/read_more/logo_plus_name.dart';
import 'package:pif_flutter/ui/home/widget/read_more/news_button.dart';

class ReadMoreView extends StatelessWidget {
  const ReadMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            SizedBox(
              height: 14.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoNameWidget(),
                NewsButton(),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 56.0),
              child: Column(
                children: [
                  CongratsText(),
                  SizedBox(
                    height: 8.h,
                  ),
                  Image.asset(Assets.humanFuture),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
