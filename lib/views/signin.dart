import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignIn({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late String email, password;
  bool isLoading = false;

  void clearText() {
    emailController.clear();
    passController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SafeArea(
          child: Container(
            //alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow.shade900,
                      ),
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(

                            //Logo
                            child: buildLogo()),
                        SizedBox(
                          height: 110,
                        ),

                        //Email address field
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Enter Email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 18.0),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Icon(
                                  Icons.mail,
                                  color: Colors.yellow.shade900,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.yellow.shade900),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.yellow.shade900),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          onChanged: (val) {
                            email = (val);
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //Password field
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          obscuringCharacter: "*",
                          autofocus: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 18.0),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.yellow.shade900,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.yellow.shade900),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.yellow.shade900),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          onChanged: (val) {
                            password = (val);
                          },
                        ),

                        SizedBox(
                          height: 24,
                        ),

                        //Sign In Button
                        GestureDetector(
                            onTap: () {
                              signIn();
                            },
                            child: orangeButton(context, "Sign In")),

                        // SizedBox(
                        //   height: 18,
                        // ),

                        //Don't have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15.5, color: Colors.black),
                                    text: "Don't have an account? ",
                                    children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = widget.onClickedSignUp,
                                      text: "Sign Up",
                                      style: TextStyle(
                                          fontSize: 15.5,
                                          decoration: TextDecoration.underline,
                                          color: Colors.yellow.shade900,
                                          fontWeight: FontWeight.bold))
                                ])),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
          ),
        ));
  }

  Future signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
      } catch (e) {
        Alert(
            style: AlertStyle(
                alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            context: context,
            type: AlertType.error,
            title: "Failed Sign In",
            desc: "Incorrect Email or Password.",
            buttons: [
              DialogButton(
                child: Text(
                  "Try Again",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.yellow.shade900,
              )
            ]).show();
        clearText();
      }
    }
  }
}
