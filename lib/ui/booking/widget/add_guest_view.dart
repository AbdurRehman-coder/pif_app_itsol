import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';

class AddGuestView extends StatelessWidget {
  const AddGuestView({
    required this.provider,
    required this.notifier,
    super.key,
  });

  final BookingState provider;
  final BookingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: Text(
                        ' ${provider.lstGuests[index].givenName![0]}${provider.lstGuests[index].familyName![0]}',
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.lstGuests[index].name ?? '',
                          style: Style.commonTextStyle(
                            color: blackColorWith900,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          provider.lstGuests[index].emailAddress ?? '',
                          style: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.60),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        notifier.removeGuest(provider.lstGuests[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Icon(
                          Icons.close,
                          color: blackColorWith900.withOpacity(0.60),
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 5.h,
              );
            },
            itemCount: provider.lstGuests.length,
          ),
        ),
        Container(
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
              ? Column(
                  children: [
                    SizedBox(
                      height: 190.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = provider.lstAutoCompleteGuests[index];
                          return Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: Text(
                                  ' ${item.givenName![0]}${item.familyName![0]}',
                                  style: Style.commonTextStyle(
                                    color: whiteColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Style.commonTextStyle(
                                        color: blackColorWith900,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      item.emailAddress ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Style.commonTextStyle(
                                        color:
                                            blackColorWith900.withOpacity(0.60),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: item.isSelected,
                                onChanged: (value) {
                                  notifier.updateSelectedGuest(model: item);
                                },
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 15.h,
                            thickness: 1.h,
                            color: textFieldBorderColor,
                          );
                        },
                        itemCount: provider.lstAutoCompleteGuests.length,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: notifier.addGuest,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(context.screenWidth, 48.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(color: primaryColor, width: 1.w),
                        ),
                        backgroundColor: whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            S.of(context).addSelected,
                            style: Style.commonTextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
