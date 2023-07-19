import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/side_menu/model/side_menu_model.dart';
import 'package:pif_flutter/ui/side_menu/model/theme_model.dart';
import 'package:pif_flutter/ui/side_menu/state/side_menu_state.dart';

final sideMenuProvider = StateNotifierProvider.autoDispose<SideMenuNotifier, SideMenuState>((ref) {
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
    lstMenu.add(SideMenuModel(name: S.current.profileSetting, icon: Assets.profileIcon));
    lstMenu.add(SideMenuModel(name: S.current.handBook, icon: Assets.handBookIcon));
    lstMenu.add(SideMenuModel(name: S.current.appTour, icon: Assets.appTourIcon));
    lstMenu.add(SideMenuModel(name: S.current.termsOfService, icon: Assets.termsIcon));
    lstMenu.add(SideMenuModel(name: S.current.faq, icon: Assets.faqIcon));
    lstMenu.add(SideMenuModel(name: S.current.arabic, icon: Assets.languageIcon));
    lstMenu.add(SideMenuModel(name: S.current.logout, icon: Assets.logoutIcon));
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

  //Menu Item Click
  void onItemTap({required int index}) {
    if (lstMenu[index].name == S.current.profileSetting) {
      AppRouter.pushNamed(Routes.employeeDetailsScreen, args: true);
    } else if (lstMenu[index].name == S.current.handBook) {
    } else if (lstMenu[index].name == S.current.appTour) {
    } else if (lstMenu[index].name == S.current.termsOfService) {
    } else if (lstMenu[index].name == S.current.faq) {
    } else if (lstMenu[index].name == S.current.arabic) {
    } else if (lstMenu[index].name == S.current.logout) {
      DixelsSDK.instance.logout();
      AppRouter.startNewRoute(Routes.logInScreen);
    }
  }
}
