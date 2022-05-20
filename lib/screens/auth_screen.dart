import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(BuildContext ctx, String email, String password,
      String username, bool isLogin, File? userImage) {
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/pics/login_cover.jpeg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AuthForm(
          isLoading: false,
          onSubmit: _submitAuthForm,
        ),
      ),
    );
  }
}
