import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/forget_password_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/login_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/screens_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/signup_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/presentation/views/home/main_hub.dart';
import 'package:wewa/presentation/views/login_signup_pages/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool flag = true;
handleRememberMe()async
{
  FlutterSecureStorage storage = FlutterSecureStorage();
  var res = await storage.read(key: 'email');
  if(res == null){
    return null;
  }else{
    print(res);
    return res;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var res = await handleRememberMe();
  if(res == null){
    flag = true;
  }else{
    flag = false;
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LoginCubit(),
      ),
      BlocProvider(
        create: (context) => ForgetPasswordCubit(),
      ),
      BlocProvider(
        create: (context) => SignupCubit()..addval(),
      ),
      BlocProvider(
        create: (context) => WewaProductsCubit(),
      ),
      BlocProvider(
        create: (context) => WewaProductsCubit()..fillCategories()..getFilteredFlavors('121'),
      ),
      BlocProvider(
        create: (context) => ScreensCubit()..ScreensInitializer(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
            backgroundColor: Color(0xff0CB502),
            splashIconSize: MediaQuery.of(context).size.height * 0.1,
            splash: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset(
                'assets/images/logos/SplashLogo.svg',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.contain,
              ),
            ),
            animationDuration: Duration(seconds: 1),
            curve: Curves.linear,
            nextScreen: flag == true?OnboardingScreen():MainHub(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
          ),
    );
  }
}
