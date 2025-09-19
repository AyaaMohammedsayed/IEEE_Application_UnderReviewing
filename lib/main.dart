import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_colors.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
  runApp(MyApp(appRouter: AppRouter(),seenOnboarding: seenOnboarding,));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool seenOnboarding;
  const MyApp({super.key, required this.appRouter,required this.seenOnboarding});

  // This widget is the root of your application.
  // can be seperated to a new file
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'IEEE App',
        onGenerateRoute: appRouter.generateRoute,
        
       initialRoute: seenOnboarding
    ? (FirebaseAuth.instance.currentUser != null
        ? Routes.homeScreen
        : Routes.registerScreen)
    : Routes.onboardinScreen,

      ),
    );
  }
}
