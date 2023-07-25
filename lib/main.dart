import 'package:camera/camera.dart';
import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

late List<CameraDescription> camerasList;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  camerasList = await availableCameras();
  // await DisposableImages.init();

  runApp(const ProviderScope(child: MyApp()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = primaryColor
    ..backgroundColor = Colors.transparent
    ..indicatorColor = primaryColor
    ..textColor = primaryColor
    ..maskColor = Colors.transparent.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        title: 'PIF',
        theme: Style.defaultTheme,
        initialRoute: AppRouter.initialRoute,
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [NavigationHistoryObserver()],
        localizationsDelegates: const [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) {
          return UnFocusWidget(child: child!);
        },
      ),
    );
  }
}

class UnFocusWidget extends StatelessWidget {
  const UnFocusWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
