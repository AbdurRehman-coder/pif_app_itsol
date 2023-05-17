import 'package:flutter/material.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/booking_page.dart';
import 'package:pif_flutter/ui/home/home_page.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_page.dart';
import 'package:pif_flutter/ui/splash/splash_page.dart';

class AppRouter {
  const AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// The name of the route that loads on app startup
  static const String initialRoute = Routes.splashScreen;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _setPage(page: const SplashPage(), settings: settings);
      case Routes.homeScreen:
        return _setPage(page: const HomePage(), settings: settings);
      case Routes.spaceBookingScreen:
        return _setPage(page: const SpaceBookingPage(), settings: settings);
      case Routes.bookingScreen:
        return _setPage(page: const BookingPage(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _setPage({
    required Widget page,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: settings,
    );
  }

  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName,
    String untilRoute, {
    dynamic args,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(untilRoute),
      arguments: args,
    );
  }

  static Future<dynamic> pushReplacement(String routeName, {dynamic args}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: args);
  }

  static Future<dynamic> popAndPushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName, arguments: args);
  }

  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }

  static Future<dynamic> startNewRoute(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: args,
    );
  }
}
