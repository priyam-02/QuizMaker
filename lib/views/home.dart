import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.yellow.shade900,
          ),
          tooltip: 'Menu',
          onPressed: () {},
        ),
        actions: [
          Tooltip(
            message: 'Sign Out',
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.yellow.shade900,
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ),
        ],
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade900,
        child: Icon(
          Icons.add,
        ),
        tooltip: 'Create Quiz',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}
