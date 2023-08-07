import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';
import 'package:pif_flutter/common/utilities/constant.dart';

class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({
    required this.creator,
    required this.dateCreated,
    super.key,
  });

  final Creator creator;
  final DateTime dateCreated;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (creator.image != null) ...[
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: grayBorderColor,
                width: 1.w,
              ),
            ),
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: Constant.imageBaseUrl + (creator.image ?? ''),
            ),
          ),
        ] else ...[
          ImageProfileVisitor(
            firstName: creator.givenName ?? '',
            lastName: creator.familyName ?? '',
          ),
        ],
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              creator.name ?? '',
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              dateCreated.daysBetween,
              style: Style.commonTextStyle(
                color: darkBorderColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
