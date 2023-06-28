import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/booking_list_page.dart';
import 'package:pif_flutter/ui/drinks/drinks_page.dart';
import 'package:pif_flutter/ui/home/model/bottom_menu_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final lstMenu = <BottomMenuModel>[];
  var _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    lstMenu.add(
      BottomMenuModel(
        icon: Assets.home,
        title: 'Home',
        child: const SizedBox(),
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
    // loginAsync();
  }

  // Future<void> loginAsync() async {
  //   final userName = await SecurePreferences.instance
  //       .read(key: SecurePreferencesKeys.userName);
  //   final password = await SecurePreferences.instance
  //       .read(key: SecurePreferencesKeys.password);
  //
  //   await DixelsSDK.initialize(
  //     baseUrl: 'http://20.74.136.229',
  //     auth: OAuth2PasswordGrant(
  //       username: userName ?? '',
  //       password: password ?? '',
  //       clientId: 'id-b84ecd78-bb26-7be2-7c9d-661ee729b6a',
  //       clientSecret: 'secret-52b3de81-3a44-b6c9-d63b-92e1ecf16e',
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: _bottomNavIndex == 1
            ? Column(
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
              )
            : null,
        leading: IconButton(
          onPressed: () {
            DixelsSDK.instance.logout();
            AppRouter.startNewRoute(Routes.logInScreen);
          },
          icon: SvgPicture.asset(
            Assets.menu,
            height: 30.h,
            width: 30.w,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SvgPicture.asset(
              Assets.message,
              height: 24.h,
              width: 24.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 12.w),
            child: SvgPicture.asset(
              Assets.notification,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        child: lstMenu.elementAt(_bottomNavIndex).child!,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
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
