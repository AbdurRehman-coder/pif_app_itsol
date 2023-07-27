import 'package:camera/camera.dart';
import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:pif_flutter/database/hive_adapters.dart';
import 'package:pif_flutter/database/hive_storage.dart';
import 'package:pif_flutter/database/settings.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

late List<CameraDescription> camerasList;
final hiveStorageProvider = Provider.autoDispose<HiveStorage>((ref) => throw Error());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  final hiveStorage = await HiveStorage.getInstance(
    boxName: 'pifBox',
    registerAdapters: registerHiveAdapters,
  );

  camerasList = await availableCameras();
  await DisposableImages.init();

  runApp(
    ProviderScope(
      overrides: [
        hiveStorageProvider.overrideWithValue(hiveStorage),
      ],
      child: const MyApp(),
    ),
  );
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    Settings.init(context);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(390, 844),
      // designSize: ScreenUtil.defaultSize,
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

  @override
  void dispose() {
    disposeHive();
    super.dispose();
  }

  Future<void> disposeHive() async {
    if (!kDebugMode) {
      final hiveStorage = await HiveStorage.getInstance(boxName: 'pifBox');
      await hiveStorage.close();
    }
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
