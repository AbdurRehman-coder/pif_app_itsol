import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/booking_list_page.dart';
import 'package:pif_flutter/ui/dashboard/model/bottom_menu_model.dart';
import 'package:pif_flutter/ui/drinks/drinks_page.dart';
import 'package:pif_flutter/ui/home/home_page.dart';
import 'package:pif_flutter/ui/side_menu/side_menu_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final lstMenu = <BottomMenuModel>[];
  var _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.home,
        title: 'Home',
        child: const HomePage(),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.drink,
        title: 'Drink',
        child: const DrinkPage(),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.booking,
        title: 'Booking',
        child: const BookingListPage(),
      ),
    );
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.social,
        title: 'Social',
        child: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? title;
    if (_bottomNavIndex == 0) {
      title = Row(
        children: [
          SizedBox(
            width: 50.h,
          ),
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
      title = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).deliveringTo,
            style: Style.commonTextStyle(
              color: grayTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 14.w),
              Text(
                'Al-Multaqa 301',
                style: Style.commonTextStyle(
                  color: primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(Assets.smallArrowDown),
            ],
          ),
        ],
      );
    } else {
      title = null;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            _bottomNavIndex == 0 ? lightGrayBgColor : Colors.transparent,
        centerTitle: true,
        title: title,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: InkWell(
                onTap: () {
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SvgPicture.asset(
              Assets.message,
              height: 24.h,
              width: 24.w,
            ),
          ).visibility(visible: _bottomNavIndex != 0),
          if (_bottomNavIndex == 0)
            InkWell(
              onTap: () => AppRouter.pushNamed(Routes.myTicketsScreen),
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
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SvgPicture.asset(
                Assets.notification,
                height: 24.h,
                width: 24.w,
              ),
            ),
        ],
      ),
      drawer: const SideMenuPage(),
      body: NotificationListener<ScrollNotification>(
        child: lstMenu.elementAt(_bottomNavIndex).child!,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(
          Assets.instant,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        elevation: 0,
        itemCount: lstMenu.length,
        shadow: const Shadow(
          blurRadius: 30,
          color: borderColor,
        ),
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? primaryColor : Colors.black26;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                lstMenu[index].icon!,
                fit: BoxFit.cover,
                color: color,
              )
            ],
          );
        },
        backgroundColor: whiteColor,
        activeIndex: _bottomNavIndex,
        splashColor: primaryColor,
        splashRadius: 0,
        splashSpeedInMilliseconds: 200,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() {
          _bottomNavIndex = index;
          if (index == 3) {
            AppRouter.pushNamed(Routes.visitListScreen);
          }
        }),
      ),
    );
  }
}
