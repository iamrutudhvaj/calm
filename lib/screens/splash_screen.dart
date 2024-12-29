import 'package:calm/blocs/auth_bloc/auth_bloc.dart';
import 'package:calm/screens/home_screen.dart';
import 'package:calm/screens/login_screen.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthStatusRequested());
    Future.delayed(
      2.seconds,
      () {
        if (mounted) {
          var state = context.read<AuthBloc>().state;
          if (state.status == AuthStatus.authenticated) {
            Navigator.pushReplacementNamed(context, HomeScreen.route);
          } else if (state.status == AuthStatus.unauthenticated ||
              state.status == AuthStatus.initial) {
            Navigator.pushReplacementNamed(context, LoginScreen.route);
          } else {
            Navigator.pushReplacementNamed(context, LoginScreen.route);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Calm",
              style: TextStyle(
                fontFamily: "Cookie",
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Find Your Calm, Anytime."),
          ],
        ),
      ),
    );
  }
}