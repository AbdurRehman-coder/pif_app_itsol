import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/model/category_model.dart';
import 'package:pif_flutter/ui/home/states/home_states.dart';
import 'package:pif_flutter/ui/home/widget/comming_visitor_card.dart';
import 'package:pif_flutter/ui/home/widget/meeting_card.dart';
import 'package:pif_flutter/ui/home/widget/order_status_card.dart';
import 'package:pif_flutter/ui/home/widget/support_status_card.dart';
import 'package:pif_flutter/ui/home/widget/today_status.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeStates>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<HomeStates> {
  HomeNotifier({required this.ref}) : super(HomeStates.initial()) {
    _initData();
  }

  final Ref ref;
  List<CategoryModel> lstCategory = <CategoryModel>[];
  List<Widget> statusList = [
    const TodayStatus(),
    const SupportStatusCard(),
    const MeetingCard(),
    const ComingVisitorCard(),
    const OrderStatusCard(),
  ];

  void _initData() {
    lstCategory.add(
      CategoryModel(
        image: Assets.qrView,
        text: 'QR Scan',
        onTap: () => AppRouter.pushNamed(Routes.bookingScannerScreen),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.creative,
        text: 'Photography',
        onTap: () => AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: '180101',
            isSelectedSubCategory: '180110',
          ),
        ),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.visitor,
        text: 'New Visit',
        onTap: () => AppRouter.pushNamed(
          Routes.inviteVisitorScreen,
          args: true,
        ),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.qrView,
        text: 'Booking',
        onTap: () => AppRouter.pushNamed(Routes.spaceBookingScreen),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.creative,
        text: 'New Joiner',
        onTap: () => AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: '180101',
            isSelectedSubCategory: '180110',
          ),
        ),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.creative,
        text: 'IT Support',
        onTap: () => AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: '180101',
          ),
        ),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.creative,
        text: 'Logistics',
        onTap: () => AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: '180101',
          ),
        ),
      ),
    );
    lstCategory.add(
      CategoryModel(
        image: Assets.creative,
        text: 'Creatives',
        onTap: () => AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: '180101',
          ),
        ),
      ),
    );

    state = state.copyWith(lstCategory: lstCategory);
  }
}
