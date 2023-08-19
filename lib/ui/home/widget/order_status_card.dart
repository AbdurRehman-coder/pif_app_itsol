import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:dixels_sdk/features/content/cards/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/widget/order_status_icon.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    required this.order,
    super.key,
  });

  final OrderModel order;

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
        horizontal: 13.w,
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
                  avatars: order.images!
                      .map((image) => NetworkImage(image.getImageUrl))
                      .toList(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    OrderStatusIcon(
                      orderStatusText: S.current.received,
                      orderStatusIcon: Assets.recived,
                      orderStatusSelected: order.step! == 1,
                    ),
                    OrderStatusIcon(
                      orderStatusText: S.current.preparing,
                      orderStatusIcon: Assets.delivered,
                      orderStatusSelected: order.step! == 2,
                    ),
                    OrderStatusIcon(
                      orderStatusText: S.current.ready,
                      orderStatusIcon: Assets.drinks,
                      isLastItem: true,
                      orderStatusSelected: order.step! == 3,
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
