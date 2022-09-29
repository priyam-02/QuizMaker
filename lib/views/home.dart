import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/background.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/views/play_quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService databaseService = new DatabaseService();
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder(
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade900,
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return QuizTile(
                    imgUrl: snapshot.data!.docs[index].data()["quizImgUrl"],
                    title: snapshot.data!.docs[index].data()["quizTitle"],
                    desc: snapshot.data!.docs[index].data()["quizDescription"],
                    quizid: snapshot.data!.docs[index].data()["quizId"]);
              });
        },
        stream: FirebaseFirestore.instance.collection("Quiz").snapshots(),
      ),
    );
  }

  @override
  void initState() {
    var quizStream = FirebaseFirestore.instance.collection("Quiz").snapshots();
    databaseService.getQuizezData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
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
          body: quizList(),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.yellow.shade900,
            child: Icon(
              Icons.add,
            ),
            tooltip: 'Create Quiz',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateQuiz()));
            },
          ),
        ),
      ]),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;

  const QuizTile(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.quizid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizid)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8, top: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 30,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
