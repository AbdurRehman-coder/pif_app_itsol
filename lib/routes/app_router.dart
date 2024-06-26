import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/booking/model/nearest_room_model.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart' as Structure;
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/book_scanner/book_scanner_view.dart';
import 'package:pif_flutter/ui/booking/booking_page.dart';
import 'package:pif_flutter/ui/booking_calender/booking_calender_page.dart';
import 'package:pif_flutter/ui/booking_details/booking_details_view.dart';
import 'package:pif_flutter/ui/booking_list/booking_list_page.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/comany_and_news.dart';
import 'package:pif_flutter/ui/company_managment/company_details/company_details_page.dart';
import 'package:pif_flutter/ui/dashboard/dashboard_page.dart';
import 'package:pif_flutter/ui/employee_details/employee_details_page.dart';
import 'package:pif_flutter/ui/employee_details/employee_profile_edit_page.dart';
import 'package:pif_flutter/ui/home/widget/read_more/news_details_view.dart';
import 'package:pif_flutter/ui/notifications/notification_page.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/fill_all_information.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/privacy_screen.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/scan_face_camera.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/welcome_sceen.dart';
import 'package:pif_flutter/ui/on_boarding/login/login_page.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/verify_otp.dart';
import 'package:pif_flutter/ui/search_location/index.dart';
import 'package:pif_flutter/ui/side_menu/widget/handbook_view.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_page.dart';
import 'package:pif_flutter/ui/splash/splash_page.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/add_view.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/my_tickets_view.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/ticket_details_page.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/invite_edit_visit_page.dart';
import 'package:pif_flutter/ui/visit/visit_list/invitation_details.dart';
import 'package:pif_flutter/ui/visit/visit_list/visits_list_view.dart';

class AppRouter {
  const AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The name of the route that loads on app startup
  static const String initialRoute = Routes.splashScreen;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _setPage(page: const SplashPage(), settings: settings);
      case Routes.logInScreen:
        return _setPage(page: const LogInPage(), settings: settings);
      case Routes.dashboardScreen:
        return _setPage(page: const DashboardPage(), settings: settings);
      case Routes.spaceBookingScreen:
        return _setPage(page: const SpaceBookingPage(), settings: settings);
      case Routes.bookingListScreen:
        return _setPage(page: const BookingListPage(), settings: settings);
      case Routes.bookingScannerScreen:
        final isFromSpace = settings.arguments! as bool;
        return _setPage(
          page: BookScannerView(isFromSpace: isFromSpace),
          settings: settings,
        );
      case Routes.bookingScreen:
        final lstArgs = settings.arguments! as List<dynamic>;
        final roomModel = lstArgs[0] as RoomModel;
        final isFromScan = lstArgs[1] as bool;
        final bookingModel = lstArgs[2] as BookingModel?;
        final isFromSpace = lstArgs[3] as bool;
        final instanceModel = lstArgs[4] as NearestRoomModel?;
        return _setPage(
          page: BookingPage(
            spaceData: roomModel,
            isFromScan: isFromScan,
            bookingModel: bookingModel,
            isFromSpace: isFromSpace,
            instanceModel: instanceModel,
          ),
          settings: settings,
        );
      case Routes.bookingDetailsScreen:
        final data = settings.arguments! as BookingModel;
        return _setPage(
          page: BookingDetails(
            data: data,
          ),
          settings: settings,
        );
      case Routes.inviteVisitorScreen:
        final lstArgs = settings.arguments != null ? settings.arguments! as List<dynamic> : null;
        final fromHomepage = lstArgs?[0] as bool;
        final isInviteVisit = lstArgs?[1] as bool;
        final visitInformation = lstArgs?[2] as VisitModel?;
        return _setPage(
          page: InviteEditVisitPage(
            fromHomepage: fromHomepage,
            isInviteVisit: isInviteVisit,
            selectedVisit: visitInformation,
          ),
          settings: settings,
        );
      case Routes.visitListScreen:
        return _setPage(page: const VisitsListView(), settings: settings);
      case Routes.myTicketsScreen:
        return _setPage(page: const MyTicketsView(), settings: settings);
      case Routes.companyAndNewsScreen:
        return _setPage(page: const CompanyAndNews(), settings: settings);
      case Routes.handbookView:
        final pdfUrl = settings.arguments != null ? settings.arguments! as String : '';
        return _setPage(
          page: HandbookPDFView(pdfUrl: pdfUrl),
          settings: settings,
        );
      case Routes.addOrEditTicketScreen:
        final addTicketModel = settings.arguments != null ? settings.arguments! as AddTicketModel : null;
        return _setPage(
          page: AddTicketView(
            addTicketModel: addTicketModel,
          ),
          settings: settings,
        );
      case Routes.fillAllInformationScreen:
        final userName = settings.arguments! as String;
        return _setPage(
          page: FillAllInformationScreen(
            userName: userName,
          ),
          settings: settings,
        );
      case Routes.scanFaceCameraScreen:
        return _setPage(
          page: const ScanFaceCamera(),
          settings: settings,
        );
      case Routes.welcomeScreen:
        final userName = settings.arguments! as String;
        return _setPage(
          page: WelcomeScreen(
            userName: userName,
          ),
          settings: settings,
        );
      case Routes.verifyOTPScreen:
        final notifier = settings.arguments! as LogInNotifier;
        return _setPage(
          page: VerifyOTP(
            notifier: notifier,
          ),
          settings: settings,
        );
      case Routes.invitationDetailsScreen:
        final data = settings.arguments! as VisitModel;
        return _setPage(
          page: InvitationDetailsView(
            selectedVisit: data,
          ),
          settings: settings,
        );
      case Routes.privacyScreen:
        final lstArgs = settings.arguments != null
            ? settings.arguments! as List<dynamic>
            : null;
        final fromNda = lstArgs?[0] as bool;
        final fromDashboard = lstArgs?[1] as bool;
        return _setPage(
          page: PrivacyScreen(
            fromNda: fromNda,
            isDashboard: fromDashboard,
          ),
          settings: settings,
        );
      case Routes.ticketDetailsScreen:
        final data = settings.arguments! as SupportTicketModel;
        return _setPage(
          page: TicketDetailsPage(ticketData: data),
          settings: settings,
        );
      case Routes.companyDetailsScreen:
        final data = settings.arguments! as CompanyManagementModel;
        return _setPage(
          page: CompanyDetailsPage(data: data),
          settings: settings,
        );
      case Routes.employeeDetailsScreen:
        final lstArgs = settings.arguments! as List<dynamic>;
        final isFromProfile = lstArgs[0] as bool;
        final data = lstArgs[1] as UserModel;
        final companyModel = lstArgs[2] != null ? lstArgs[2] as CompanyManagementModel : null;

        return _setPage(
          page: EmployeeDetailsPage(
            isFromProfile: isFromProfile,
            data: data,
            companyManagementModel: companyModel,
          ),
          settings: settings,
        );
      case Routes.searchLocationScreen:
        return _setPage(page: const SearchLocationPage(), settings: settings);

      case Routes.notificationScreen:
        return _setPage(page: const NotificationPage(), settings: settings);
      case Routes.newsDetails:
        final lstArgs = settings.arguments != null ? settings.arguments! as List<dynamic> : null;
        final creator = lstArgs?[0] as Structure.Creator;
        final dateCreated = lstArgs?[1] as DateTime;
        final contentField = lstArgs?[2] as List<ContentField>;
        final newsType = lstArgs?[3] as String;

        return _setPage(
          page: NewsDetails(
            creator: creator,
            dateCreated: dateCreated,
            contentFieldValue: contentField,
            newsType: newsType,
          ),
          settings: settings,
        );

      case Routes.bookingCalenderScreen:
        final lstArgs = settings.arguments! as List<dynamic>;
        final roomModel = lstArgs[0] as RoomModel;
        final isFromBooking = lstArgs[1] as bool;
        return _setPage(
          page: BookingCalenderPage(
            spaceData: roomModel,
            isFromBooking: isFromBooking,
          ),
          settings: settings,
        );
      case Routes.editProfileDetailsScreen:
        return _setPage(
          page: EmployeeProfileEditPage(),
          settings: settings,
        );

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
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: args);
  }

  static Future<dynamic> popAndPushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: args);
  }

  static Future<dynamic> popAndPushNamedWithTransition(
    String routeName, {
    dynamic args,
  }) {
    return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: args);
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
