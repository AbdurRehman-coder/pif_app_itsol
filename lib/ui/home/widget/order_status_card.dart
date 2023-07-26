import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/widget/order_status_icon.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedPositions(
      align: StackAlign.right,
      maxCoverage: 0.3,
      minCoverage: 0.2,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.orderStatusBackground,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            S.current.orderStatus,
            style: Style.commonTextStyle(
              color: blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AvatarStack(
                  height: 40.h,
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
                  avatars: [
                    for (var i = 0; i < 2; i++) ...[
                      const NetworkImage(
                        'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                        // 'https://cdn.pixabay.com/photo/2016/12/19/08/39/mobile-phone-1917737_1280.jpg',
                      ),
                    ]
                  ],
                ),
              ),
              const Spacer(),
              const Expanded(
                flex: 3,
                child: Row(
                  children: [
                    OrderStatusIcon(
                      orderStatusText: 'Received',
                      orderStatusIcon: Assets.recived,
                      orderStatusSelected: true,
                    ),
                    OrderStatusIcon(
                      orderStatusText: 'Preparing',
                      orderStatusIcon: Assets.delivered,
                    ),
                    OrderStatusIcon(
                      orderStatusText: 'Step',
                      orderStatusIcon: Assets.drinks,
                      isLastItem: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
