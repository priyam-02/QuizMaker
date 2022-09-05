import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/addquestion.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  bool isLoading = false;

  DatabaseService databaseService = new DatabaseService();
  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(this.context,
              MaterialPageRoute(builder: (context) => AddQuestion()));
        });
      });
    }
  }

  void clearText() {
    urlController.clear();
    titleController.clear();
    descController.clear();
  }

  @override
  void dispose() {
    urlController.dispose();
    titleController.dispose();
    descController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade900,
                ),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(height: 24),
                      Text(
                        "For creating new quiz, please enter the following details:",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 100),

                      //URL Field
                      TextFormField(
                        keyboardType: TextInputType.url,
                        controller: urlController,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Image URL";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Quiz Image URL",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.link,
                                color: Colors.yellow.shade900,
                                size: 30,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          //   borderSide: BorderSide(width: 1, color: Colors.black),
                          // ),
                        ),
                        onChanged: (val) {
                          quizImageUrl = (val);
                        },
                      ),

                      SizedBox(height: 10),

                      //Title field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Quiz Title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Quiz Title",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.title,
                                color: Colors.yellow.shade900,
                                size: 30,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                        ),
                        onChanged: (val) {
                          quizTitle = val;
                        },
                      ),
                      SizedBox(height: 10),

                      //Description field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: descController,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Quiz Description";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Quiz Description",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.description,
                                color: Colors.yellow.shade900,
                                size: 30,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1, color: Colors.yellow.shade900),
                          ),
                        ),
                        onChanged: (val) {
                          quizDescription = val;
                        },
                      ),

                      SizedBox(height: 100),

                      //Create Quiz Button
                      Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow.shade900,
                                  elevation: 10,
                                  fixedSize: const Size(250, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                createQuizOnline();
                              },
                              child: Text(
                                "Create Quiz",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )))
                    ]),
                  ))),
    );
  }
}
