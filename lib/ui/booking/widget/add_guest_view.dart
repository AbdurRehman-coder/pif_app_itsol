import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';

class AddGuestView extends StatelessWidget {
  const AddGuestView({required this.provider, required this.notifier, super.key});

  final BookingState provider;
  final BookingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 18.h),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List<Widget>.generate(provider.lstGuests.length, (int index) {
                return Container(
                  width: 110.w,
                  padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.h),
                  decoration: BoxDecoration(
                    color: grayF5,
                    border: Border.all(
                      color: grayTextColor,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75.w,
                        child: Text(
                          provider.lstGuests[index].name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Style.commonTextStyle(
                            color: darkBorderColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          notifier.removeGuest(provider.lstGuests[index]);
                        },
                        child: SvgPicture.asset(
                          Assets.icClose,
                          height: 15.h,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        Container(
          height: 220.h,
          margin: EdgeInsets.symmetric(horizontal: 18.sp),
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: grayE3,
              ),
            ],
          ),
          child: provider.lstAutoCompleteGuests.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = provider.lstAutoCompleteGuests[index];
                    return InkWell(
                      onTap: () {
                        notifier.addGuest(
                          provider.lstAutoCompleteGuests[index],
                          context,
                        );
                      },
                      child: Row(
                        children: [
                          if (item.image != null && item.image!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                imageUrl: item.image!.getImageUrl,
                                width: 40.w,
                                height: 40.h,
                                placeholder: (context, url) => Image.asset(
                                  Assets.placeHolder,
                                  fit: BoxFit.fill,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  Assets.spaceBg2,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          else
                            Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: grayC0,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? '',
                                style: Style.commonTextStyle(
                                  color: darkTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                item.emailAddress ?? '',
                                style: Style.commonTextStyle(
                                  color: silverTextColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 15.h,
                      thickness: 1.h,
                      color: borderColor,
                    );
                  },
                  itemCount: provider.lstAutoCompleteGuests.length,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    SvgPicture.asset(Assets.emptyGuestBg),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      S.of(context).noMatchingResultFound,
                      textAlign: TextAlign.center,
                      style: Style.commonTextStyle(
                        color: textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
        ).visibility(visible: provider.isVisibleAddGuestList),
      ],
    );
  }
}
