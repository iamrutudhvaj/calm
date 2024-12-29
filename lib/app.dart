import 'package:calm/blocs/auth_bloc/auth_bloc.dart';
import 'package:calm/blocs/profile_bloc/profile_bloc.dart';
import 'package:calm/repositories/auth_repository.dart';
import 'package:calm/repositories/user_repository.dart';
import 'package:calm/screens/forgot_password_screen.dart';
import 'package:calm/screens/home_screen.dart';
import 'package:calm/screens/login_screen.dart';
import 'package:calm/screens/profile_screen.dart';
import 'package:calm/screens/signup_screen.dart';
import 'package:calm/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(_authRepository),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(_userRepository),
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
          ProfileScreen.route: (context) => ProfileScreen(),
          ForgotPassWordScreen.route: (context) => ForgotPassWordScreen(),
        },
      ),
    );
  }
}
