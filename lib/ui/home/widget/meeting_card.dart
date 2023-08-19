import 'package:avatar_stack/positions.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';
import 'package:pif_flutter/common/shared/package/avart_stack.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/extention/get_date_by_booking.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({required this.bookings, super.key});

  final BookingModel bookings;

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedPositions(
      align: StackAlign.right,
      maxCoverage: 0.3,
      minCoverage: 0.2,
    );
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.bookingDetailsScreen,
        args: bookings,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 20.w,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.meetingBackground,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${bookings.roomModel?.name ?? ''} ${bookings.roomModel?.rRoomCFloor?.name ?? ''}',
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 20.w,
                  color: expireStatusColor,
                ),
                SizedBox(width: 3.w),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${bookings.getStartDateByBookModel.daysBetweenWithNow} meeting',
                        style: TextStyle(
                          color: expireStatusColor,
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                    text: '${bookings.formatLeftTimeByBookModel} - ',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  child: AvatarStack(
                    height: 32.h,
                    borderColor: loggedStatusColor,
                    borderWidth: 0.5,
                    settings: settings,
                    infoWidgetBuilder: (surplus) => BorderedCircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(
                        '+$surplus',
                        textAlign: TextAlign.center,
                        style: Style.commonTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    avatars: bookings.attendees!.map((user) {
                      if (user.image != null) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                user.image!,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ImageProfileVisitor(
                          firstName: user.givenName ?? '',
                          lastName: user.familyName ?? '',
                        );
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
