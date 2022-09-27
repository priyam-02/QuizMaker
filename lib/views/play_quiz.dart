import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/views/background.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  const PlayQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  @override
  void initState() {
    print("${widget.quizId}");
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow.shade900,
            ),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          actions: [
            Tooltip(
              message: '',
              child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.transparent,
                  ),
                  onPressed: () {}),
            ),
          ],
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.yellow.shade900),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      )
    ]);
  }
}
