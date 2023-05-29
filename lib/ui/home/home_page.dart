import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/model/bottom_menu_model.dart';
import 'package:pif_flutter/utils/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final lstMenu = <BottomMenuModel>[];
  var _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    lstMenu.add(BottomMenuModel(icon: Assets.home, title: 'Home'));
    lstMenu.add(BottomMenuModel(icon: Assets.drink, title: 'Drink'));
    lstMenu.add(BottomMenuModel(icon: Assets.booking, title: 'Booking'));
    lstMenu.add(BottomMenuModel(icon: Assets.social, title: 'Social'));
    loginAsync();
  }

  Future<void> loginAsync() async {
    await DixelsSDK.initialize(
      baseUrl: 'http://20.74.136.229',
      auth: OAuth2PasswordGrant(
        username: 'vpanchal@appswave.io',
        password: 'Viral@123',
        clientId: 'id-b84ecd78-bb26-7be2-7c9d-661ee729b6a',
        clientSecret: 'secret-52b3de81-3a44-b6c9-d63b-92e1ecf16e',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
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
          if (_bottomNavIndex == 2) {
            AppRouter.pushNamed(Routes.spaceBookingScreen);
          }
        }),
      ),
    );
  }
}
