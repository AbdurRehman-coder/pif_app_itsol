import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/model/category_model.dart';
import 'package:pif_flutter/ui/home/states/home_states.dart';
import 'package:pif_flutter/ui/home/widget/comming_visitor_card.dart';
import 'package:pif_flutter/ui/home/widget/meeting_card.dart';
import 'package:pif_flutter/ui/home/widget/order_status_card.dart';
import 'package:pif_flutter/ui/home/widget/support_status_card.dart';
import 'package:pif_flutter/ui/home/widget/today_status.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';
import 'package:weather/weather.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeStates>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<HomeStates> with RouteAware {
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
    getNews();
    getServices();
    getWeather();
  }

  void onTapServices({
    required String type,
    String? categoryId,
    String? subCategoryId,
  }) {
    switch (type) {
      case 'QR Booking':
        AppRouter.pushNamed(Routes.bookingScannerScreen);
        break;
      case 'Support':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
          ),
        );
        break;
      case 'Photography':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
            isSelectedSubCategory: subCategoryId,
          ),
        );
        break;
      case 'Invite Visitors':
        AppRouter.pushNamed(
          Routes.inviteVisitorScreen,
          args: [true, true, null],
        );
        break;
      case 'New Joiner':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
          ),
        );
        break;
      case 'Logistics':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
          ),
        );
        break;
      case 'Creatives':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
          ),
        );
        break;
      case 'Booking':
        AppRouter.pushNamed(Routes.spaceBookingScreen);
        break;
    }
  }

  Future<void> getWeather() async {
    final weatherFactory = WeatherFactory(Constants.apiKeyWeather);
    const lat = 24.7747;
    const lon = 46.6371;
    final weather = await weatherFactory.currentWeatherByLocation(lat, lon);
    if (weather.tempMax != null) {
      state = state.copyWith(weatherDegree: weather.tempMax!.celsius!.toInt());
    }
  }

  Future<void> getServices() async {
    final result = await DixelsSDK.instance.structureContentService
        .getStructureByStructureId(
      structureId: '207816',
      params: ParametersModel(
        fields: 'contentFields',
        restrictFields: 'actions',
        pageSize: '8',
        sort: 'priority:desc,dateCreated:desc',
      ),
    );
    if (result.isRight()) {
      state = state.copyWith(
        servicesList: AsyncData(
          result.getRight()?.items ?? [],
        ),
      );
    }
  }

  Future<void> getNews() async {
    final result = await DixelsSDK.instance.structureContentService
        .getStructureByStructureId(
      structureId: '207731',
      params: ParametersModel(
        fields: 'taxonomyCategoryBriefs,contentFields,creator,dateCreated',
        sort: 'priority:desc,dateCreated:desc',
        restrictFields: 'actions',
        pageSize: '10',
      ),
    );
    if (result.isRight()) {
      state =
          state.copyWith(newsList: AsyncData(result.getRight()?.items ?? []));
    }
  }
}
