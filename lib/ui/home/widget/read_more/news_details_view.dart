import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/home/widget/read_more/congrates_text.dart';
import 'package:pif_flutter/ui/home/widget/read_more/logo_plus_name.dart';
import 'package:pif_flutter/ui/home/widget/read_more/news_button.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    required this.creator,
    required this.dateCreated,
    required this.contentFieldValue,
    super.key,
  });

  final Creator creator;
  final DateTime dateCreated;
  final List<ContentField> contentFieldValue;

  @override
  Widget build(BuildContext context) {
    final newsVideo = contentFieldValue
        .where((element) => element.name == 'video')
        .firstOrNull
        ?.contentFieldValue
        ?.document
        ?.contentUrl;
    final newsText = contentFieldValue
        .where((element) => element.name == 'text')
        .firstOrNull
        ?.contentFieldValue
        ?.data;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoNameWidget(
                  creator: creator,
                  dateCreated: dateCreated,
                ),
                const NewsButton(),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: Column(
                children: [
                  CongratsText(
                    newsDescription: newsText ?? '',
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (newsVideo != null) ...[
                    BannerVideoView(
                      videoUrl: newsVideo,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
