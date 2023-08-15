import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/home/widget/read_more/news_description.dart';
import 'package:pif_flutter/ui/home/widget/read_more/logo_plus_name.dart';
import 'package:pif_flutter/ui/home/widget/read_more/news_button.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    required this.creator,
    required this.newsType,
    required this.dateCreated,
    required this.contentFieldValue,
    super.key,
  });

  final Creator creator;
  final DateTime dateCreated;
  final String newsType;
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
                NewsButton(
                  newsType: newsType,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(width: 50.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NewsDescription(
                            newsDescription: newsText ?? '',
                          ),
                          SizedBox(height: 20.h),
                          if (newsVideo != null) ...[
                            SizedBox(
                              height: 200.h,
                              width: double.infinity,
                              child: BannerVideoView(
                                videoUrl: Constants.baseUrl + newsVideo,
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
