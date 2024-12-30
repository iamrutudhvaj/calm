import 'package:calm/module/auth/auth_bloc/auth_bloc.dart';
import 'package:calm/module/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushReplacementNamed(context, LoginScreen.route);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            )
          ],
        ),
        body: Center(
          child: Text('Welcome Home!'),
        ),
      ),
    );
  }
}
