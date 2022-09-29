import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/background.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/result.dart';
import 'package:quiz_app/widgets/quiz_play_widgets.dart';
import 'package:quiz_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  const PlayQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notattempted = 0.abs();

//Stream
Stream? infoStream;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot? questionsSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot["question"];

    List<String> options = [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notattempted = questionsSnapshot!.docs.length;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot!.docs.length;

      print("$total this is total");
      setState(() {});
    });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [_correct, _incorrect];
      });
    }

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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Header(
                  length: questionsSnapshot?.docs.length ?? 0,
                ),
                SizedBox(
                  height: 10,
                ),
                questionsSnapshot == null
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 280),
                        child: Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                        ))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: questionsSnapshot?.docs.length,
                        itemBuilder: ((context, index) {
                          return QuizPlayTile(
                            questionModel: getQuestionModelFromDatasnapshot(
                                questionsSnapshot!.docs[index]),
                            index: index,
                          );
                        }))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow.shade900,
            child: Icon(
              Icons.check,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Results(
                          correct: _correct,
                          incorrect: _incorrect,
                          total: total))));
            }),
      )
    ]);
  }
}

class Header extends StatefulWidget {
  final int length;
  const Header({Key? key, required this.length}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NoOfQuestionTile(
                        text: "Total",
                        number: widget.length,
                      ),
                      NoOfQuestionTile(
                        text: "Correct",
                        number: _correct,
                      ),
                      NoOfQuestionTile(
                        text: "Incorrect",
                        number: _incorrect,
                      ),
                      NoOfQuestionTile(
                        text: "NotAttempted",
                        number: _notattempted,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile(
      {Key? key, required this.questionModel, required this.index})
      : super(key: key);

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1}  ${widget.questionModel.question}",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///Correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notattempted -= 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "A",
                description: widget.questionModel.option1,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///Correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notattempted -= 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notattempted -= 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "B",
                description: widget.questionModel.option2,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///Correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notattempted -= 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "C",
                description: widget.questionModel.option3,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///Correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notattempted -= 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "D",
                description: widget.questionModel.option4,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
