import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final isLoading;
  final void Function(BuildContext ctx, String email, String password,
      String username, bool isLogin, File? userImage) onSubmit;
  const AuthForm({
    required this.isLoading,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  var _isLogin = true;
  File? _userImageFile;

  var screenWidth =
      (window.physicalSize.shortestSide / window.devicePixelRatio);
  var screenHeight =
      (window.physicalSize.longestSide / window.devicePixelRatio);

  late AnimationController _controller;
  late Animation<Size> _heightAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _heightAnimation = Tween<Size>(
      begin: Size(
        double.infinity,
        screenHeight * 0.4,
      ),
      end: Size(
        double.infinity,
        screenHeight * 0.65,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!isValid) {
      return;
    }

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: const Text(
            'Please pick an image.',
          ),
        ),
      );
      return;
    }

    widget.onSubmit(
      context,
      _userEmail.trim(),
      _userPassword.trim(),
      _userName.trim(),
      _isLogin,
      _userImageFile,
    );

    _formKey.currentState!.save();
  }

  void _onModeChange() {
    setState(() {
      if (_isLogin) {
        _isLogin = !_isLogin;
        _controller.forward();
      } else {
        _isLogin = true;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (ctx, child) => Container(
          height: _heightAnimation.value.height,
          padding: const EdgeInsets.all(
            2,
          ),
          child: child,
        ),
        child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.all(
            20,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin)
                      UserImagePicker(
                        imagePickFn: _pickedImage,
                      ),
                    TextFormField(
                      key: const ValueKey('Email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                      ),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white60,
                            // fontSize: 12,
                          ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please provide a valid emai address.';
                        }
                        if (!value.contains('@')) {
                          return 'Please provide a valid emai address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value ?? '';
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('Username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.white60,
                              // fontSize: 12,
                            ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a value.';
                          }
                          if (value.length <= 4) {
                            return 'Please enter at least 5 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value ?? '';
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('Password'),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white60,
                            // fontSize: 12,
                          ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter a password';
                        }
                        if (value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value ?? '';
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) const CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(
                          _isLogin ? 'Login' : 'Signup',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.white60,
                                    // fontSize: 12,
                                  ),
                        ),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: _onModeChange,
                        child: Text(
                          _isLogin
                              ? 'Create a new account'
                              : 'I already have an account',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.white60,
                                    // fontSize: 12,
                                  ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
