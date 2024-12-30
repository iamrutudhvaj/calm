import 'package:calm/blocs/auth_bloc/auth_bloc.dart';
import 'package:calm/blocs/intro_bloc/intro_bloc.dart';
import 'package:calm/blocs/intro_bloc/intro_bloc.dart';
import 'package:calm/repositories/auth_repository.dart';
import 'package:calm/screens/forgot_password_screen.dart';
import 'package:calm/screens/home_screen.dart';
import 'package:calm/screens/intro_screen.dart';
import 'package:calm/screens/login_screen.dart';
import 'package:calm/screens/signup_screen.dart';
import 'package:calm/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(_authRepository),
        ),
        BlocProvider(
          create: (context) => IntroBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          LoginScreen.route: (context) => LoginScreen(),
          SignUpScreen.route: (context) => SignUpScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          ForgotPassWordScreen.route: (context) => ForgotPassWordScreen(),
          IntroScreen.route: (context) => IntroScreen(),
        },
      ),
    );
  }
}
