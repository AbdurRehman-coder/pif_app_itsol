import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/constants/service_constant.dart';
import 'package:dixels_sdk/features/commerce/products/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    required this.item,
    this.withOutSearch = false,
    super.key,
  });

  final CategoryModel item;
  final bool withOutSearch;

  @override
  Widget build(BuildContext context) {
    final bgColor = withOutSearch
        ? item.isSelected ?? false
            ? primaryDarkColor
            : expireBgColor
        : expireBgColor;
    final textColor = withOutSearch
        ? item.isSelected ?? false
            ? whiteColor
            : darkBorderColor
        : darkBorderColor;
    final iconUrl = (item.taxonomyCategoryProperties != null &&
            item.taxonomyCategoryProperties!.isNotEmpty)
        ? ServiceConstant.baseUrl + item.taxonomyCategoryProperties![0].value!
        : '';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: bgColor,
      ),
      padding: EdgeInsets.only(
        left: 10.w,
        right: 18.w,
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            padding: EdgeInsets.all(3.r),
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: iconUrl.isEmpty
                ? Image.asset(
                    Assets.hotDrink,
                  )
                : CachedNetworkImage(
                    imageUrl: iconUrl,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
          ),
          SizedBox(width: 8.w),
          Text(
            item.name ?? '',
            style: Style.commonTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
