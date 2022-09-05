import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  const AddQuestion({Key? key, required this.quizId}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final quesController = TextEditingController();
  final op1Controller = TextEditingController();
  final op2Controller = TextEditingController();
  final op3Controller = TextEditingController();
  final op4Controller = TextEditingController();

  late String question, option1, option2, option3, option4;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;

  void clearText() {
    quesController.clear();
    op1Controller.clear();
    op2Controller.clear();
    op3Controller.clear();
    op4Controller.clear();
  }

  @override
  void dispose() {
    quesController.dispose();
    op1Controller.dispose();
    op2Controller.dispose();
    op3Controller.dispose();
    op4Controller.dispose();

    super.dispose();
  }

  uploadQuestionData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
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
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => CreateQuiz()));
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
                        "Please enter the following details to successfully create a quiz:",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 100),

                      //Question Field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: quesController,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "This field cannot be kept empty!!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter the question",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.question_mark,
                                color: Colors.yellow.shade900,
                                size: 35,
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
                          question = (val);
                        },
                      ),

                      SizedBox(height: 10),

                      //Option 1 field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: op1Controller,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter the Option 1";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option 1 | (Correct Answer)",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.circle_rounded,
                                color: Colors.grey.shade500,
                                size: 18,
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
                          option1 = (val);
                        },
                      ),

                      SizedBox(height: 10),

                      //Option 2 field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: op2Controller,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter the Option 2";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option 2",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.circle_rounded,
                                color: Colors.grey.shade500,
                                size: 18,
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
                          option2 = (val);
                        },
                      ),

                      SizedBox(height: 10),

                      //Option 3 field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: op3Controller,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter the Option 3";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option 3",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.circle_rounded,
                                color: Colors.grey.shade500,
                                size: 18,
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
                          option3 = (val);
                        },
                      ),

                      SizedBox(height: 10),

                      //Option 4 field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: op4Controller,
                        autofocus: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter the Option 4";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option 4",
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.circle_rounded,
                                color: Colors.grey.shade500,
                                size: 18,
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
                          option4 = (val);
                        },
                      ),

                      SizedBox(height: 100),

                      //Submit Button
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 36,
                            margin: EdgeInsets.only(left: 17),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow.shade900,
                                    elevation: 10,
                                    fixedSize: const Size(160, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),

                          //Add question Button
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 36,
                            margin: EdgeInsets.only(right: 17),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow.shade900,
                                    elevation: 10,
                                    fixedSize: const Size(160, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  uploadQuestionData();
                                  clearText();
                                },
                                child: Text(
                                  "Add Question",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      )
                    ])))));
  }
}
