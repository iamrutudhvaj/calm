import 'package:calm/module/auth/auth_bloc/auth_bloc.dart';
import 'package:calm/gen/assets.gen.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassWordScreen extends StatelessWidget {
  static const String route = "/forgot-password";

  final TextEditingController _emailController = TextEditingController();

  ForgotPassWordScreen({super.key});

  void forgotPassword(BuildContext context) {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email is required'),
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
          ResetPasswordLinkRequested(
            _emailController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.status == AuthStatus.authError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Assets.images.forgotPassword.svg(height: 200),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                onSubmitted: (value) {
                  forgotPassword(context);
                },
              ),
              50.heightBox,
              ElevatedButton(
                onPressed: () {
                  forgotPassword(context);
                },
                child: Text('Forgot Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
