import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/views/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin ? SignIn(onClickedSignUp: toggle) : SignUp(onClickedSignIn: toggle);
  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}
