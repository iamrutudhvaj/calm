import 'package:calm/blocs/auth_bloc/auth_bloc.dart';
import 'package:calm/gen/assets.gen.dart';
import 'package:calm/screens/home_screen.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/signup';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignUpScreen({super.key});

  void signUp(BuildContext context) {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!!!')),
      );
      return;
    }

    if (!_emailController.text.isValidEmail()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email address!!!')),
      );
      return;
    }

    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 8 characters')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password does not match!!!')),
      );
      return;
    }

    context.read<AuthBloc>().add(
          SignUpRequested(
            _emailController.text,
            _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, HomeScreen.route);
          } else if (state.status == AuthStatus.authError) {
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
                  child: Assets.images.signUp.svg(height: 200),
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
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
                TextField(
                  controller: _confirmPasswordController,
                  onSubmitted: (value) {
                    signUp(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                20.heightBox,
                ElevatedButton(
                  onPressed: () {
                    signUp(context);
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
