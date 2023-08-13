import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/comany_and_news.dart';
import 'package:pif_flutter/ui/dashboard/model/bottom_menu_model.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/dashboard/widget/circle_menu.dart';
import 'package:pif_flutter/ui/drinks/drinks_page.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';
import 'package:pif_flutter/ui/home/home_page.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';
import 'package:pif_flutter/ui/services/index.dart';
import 'package:pif_flutter/ui/side_menu/side_menu_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  final lstMenu = <BottomMenuModel>[];
  var _bottomNavIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMenuOpen = false;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.home,
        title: S.current.home,
        child: HomePage(
          animationController: animationController!,
        ),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.drink,
        title: S.current.drinks,
        child: const DrinkPage(),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.hubIcon,
        title: S.current.hub,
        child: const CompanyAndNews(),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.servicesIcon,
        title: S.current.services,
        child: const ServicePage(),
      ),
    );
    setState(() {});

    Future.delayed(Duration.zero, () {
      ref.read(dashboardProvider.notifier).initPenguin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(dashboardProvider.notifier);
    Widget? title;
    if (_bottomNavIndex == 0) {
      title = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.logo,
            height: 39.h,
            width: 39.w,
          ),
          SizedBox(
            width: 10.h,
          ),
          Image.asset(
            Assets.pifLogo,
          ),
        ],
      );
    } else if (_bottomNavIndex == 1) {
      final notifier = ref.read(drinksProvider.notifier);
      title = SearchTextField(
        textEditingController: notifier.searchController,
        hintText: S.of(context).search,
        onChanged: notifier.searchData,
        focusNode: notifier.searchFocusNode,
      );
    } else if (_bottomNavIndex == 2) {
      title = SearchTextField(
        textEditingController: TextEditingController(),
        hintText: S.current.searchHub,
      );
    } else {
      title = SearchTextField(
        textEditingController: TextEditingController(),
        hintText: S.current.searchService,
      );
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () => notifier.closeFloatMenu(
            animationController: animationController!,
          ),
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: _bottomNavIndex == 0 || _bottomNavIndex == 3
                  ? lightGrayBgColor
                  : Colors.transparent,
              centerTitle: true,
              title: title,
              leading: Builder(
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: InkWell(
                      onTap: () {
                        notifier.closeFloatMenu(
                          animationController: animationController!,
                        );
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        Assets.person,
                        height: 40.h,
                        width: 40.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  );
                },
              ),
              actions: [
                if (_bottomNavIndex == 0) ...[
                  InkWell(
                    onTap: () => AppRouter.pushNamed(Routes.notificationScreen),
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      margin: EdgeInsets.only(right: 16.w),
                      decoration: const BoxDecoration(
                        color: activeBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        Assets.svgNotification,
                        height: 24.h,
                        width: 24.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            drawer: const SideMenuPage(),
            onDrawerChanged: (val) {
              if (!isMenuOpen) {
                notifier.closeVideoFun(
                  onTap: () {
                    setState(() {
                      isMenuOpen = val;
                    });
                  },
                );
              } else {
                setState(() {
                  isMenuOpen = val;
                });
              }
            },
            body: NotificationListener<ScrollNotification>(
              child: lstMenu.elementAt(_bottomNavIndex).child!,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: SizedBox(
              height: 40.h,
              width: 60.w,
            ),
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              elevation: 0,
              itemCount: lstMenu.length,
              shadow: const Shadow(
                blurRadius: 30,
                color: borderColor,
              ),
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? primaryColor : textColor;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      lstMenu[index].icon!,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (!isActive) ...[
                      Text(
                        lstMenu[index].title ?? '',
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                    if (isActive) ...[
                      const CircleAvatar(
                        radius: 2,
                        backgroundColor: primaryDarkColor,
                      ),
                    ]
                  ],
                );
              },
              backgroundColor: whiteColor,
              activeIndex: _bottomNavIndex,
              splashColor: primaryColor,
              splashRadius: 0,
              borderColor: primaryColor,
              leftCornerRadius: 20.r,
              rightCornerRadius: 20.r,
              splashSpeedInMilliseconds: 200,
              notchSmoothness: NotchSmoothness.softEdge,
              gapLocation: GapLocation.center,
              onTap: (index) => setState(
                () {
                  notifier.closeFloatMenu(
                    animationController: animationController!,
                  );
                  _bottomNavIndex = index;
                },
              ),
            ),
          ),
        ),
        CircleMenu(
          animationController: animationController!,
          isHided: isMenuOpen,
        ),
      ],
    );
  }
}
