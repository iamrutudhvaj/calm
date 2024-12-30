import 'package:calm/module/auth/auth_bloc/auth_bloc.dart';
import 'package:calm/gen/assets.gen.dart';
import 'package:calm/module/auth/forgot_password_screen.dart';
import 'package:calm/module/home/home_screen.dart';
import 'package:calm/module/auth/signup_screen.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "/login";

  final TextEditingController _emailController =
      TextEditingController(text: "dev.rutudhvaj@gmail.com".debug);
  final TextEditingController _passwordController =
      TextEditingController(text: "wdDsCWa79s54t8E".debug);

  LoginScreen({super.key});

  void login(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email and Password are required'),
        ),
      );
      return;
    }

    if (!_emailController.text.isValidEmail()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email is not valid'),
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
          LoginRequested(
            _emailController.text,
            _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.route, (route) => false);
          } else if (state.status == AuthStatus.authError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state.status == AuthStatus.authLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Assets.images.secureLogin.svg(height: 200),
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onSubmitted: (value) {
                    login(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(TooglePasswordVisibility());
                      },
                      icon: Icon(state.obsecuredText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: state.obsecuredText,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassWordScreen.route);
                    },
                    child: Text('Forgot Password?'),
                  ),
                ),
                10.heightBox,
                ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  child: Text('Login'),
                ),
                10.heightBox,
                ElevatedButton.icon(
                  icon: Assets.icons.google.svg(height: 20),
                  onPressed: () {
                    context.read<AuthBloc>().add(GoogleSignInRequested());
                  },
                  label: Text('Login with Google'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.route);
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
