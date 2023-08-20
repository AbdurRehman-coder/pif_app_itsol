import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/side_menu/model/side_menu_model.dart';
import 'package:pif_flutter/ui/side_menu/model/theme_model.dart';
import 'package:pif_flutter/ui/side_menu/state/side_menu_state.dart';

final sideMenuProvider =
    StateNotifierProvider.autoDispose<SideMenuNotifier, SideMenuState>((ref) {
  return SideMenuNotifier(ref: ref);
});

class SideMenuNotifier extends StateNotifier<SideMenuState> {
  SideMenuNotifier({required this.ref}) : super(SideMenuState.initial()) {
    _bindThemeData();
    _bindMenuItem();
  }

  final Ref ref;
  late List<SideMenuModel> lstMenu;

  void _bindThemeData() {
    final lstData = <ThemeModel>[];
    lstData.add(ThemeModel(icon: Assets.darkModeIcon, isSelected: false));
    lstData.add(ThemeModel(icon: Assets.darkAutoIcon, isSelected: false));
    lstData.add(ThemeModel(icon: Assets.lightModeIcon, isSelected: true));

    state = state.copyWith(lstTheme: lstData);
  }

  void _bindMenuItem() {
    lstMenu = <SideMenuModel>[];
    lstMenu.add(
      SideMenuModel(name: S.current.profileSetting, icon: Assets.profileIcon),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.handBook, icon: Assets.handBookIcon),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.TermsAndConditions, icon: Assets.termsIcon),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.booking, icon: Assets.basicCalendar),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.visits, icon: Assets.personAdd),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.supportTickets, icon: Assets.forum),
    );
    lstMenu.add(
      SideMenuModel(name: S.current.logout, icon: Assets.logoutIcon),
    );
  }

  //Update Theme
  void updateTheme(int index) {
    state.lstTheme?.forEach((element) {
      element.isSelected = false;
    });
    final data = state.lstTheme![index];
    data.isSelected = true;

    state = state.copyWith(lstTheme: state.lstTheme);
  }

  final pdfUrl = 'http://20.74.136.229/documents/d/guest/resident-handbook';
  //Menu Item Click
  Future<void> onItemTap({required int index}) async {
    if (lstMenu[index].name == S.current.profileSetting) {
      final userDetails = await DixelsSDK.instance.userDetails;
      await AppRouter.pushNamed(
        Routes.employeeDetailsScreen,
        args: [true, userDetails, '', 2022],
      );
    } else if (lstMenu[index].name == S.current.handBook) {
      await AppRouter.pushNamed(Routes.handbookView, args: pdfUrl);
    } else if (lstMenu[index].name == S.current.appTour) {
    } else if (lstMenu[index].name == S.current.TermsAndConditions) {
      await AppRouter.pushNamed(Routes.privacyScreen, args: false);
    } else if (lstMenu[index].name == S.current.faq) {
    } else if (lstMenu[index].name == S.current.arabic) {
    } else if (lstMenu[index].name == S.current.booking) {
      await AppRouter.pushNamed(Routes.bookingListScreen);
    } else if (lstMenu[index].name == S.current.visits) {
      await AppRouter.pushNamed(Routes.visitListScreen);
    } else if (lstMenu[index].name == S.current.supportTickets) {
      await AppRouter.pushNamed(Routes.myTicketsScreen);
    } else if (lstMenu[index].name == S.current.logout) {
      DixelsSDK.instance.logout();
      AppRouter.startNewRoute(Routes.logInScreen);
    }
  }
}
