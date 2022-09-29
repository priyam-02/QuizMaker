import 'package:flutter/material.dart';
import 'package:quiz_app/views/home.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;

  const Results(
      {Key? key,
      required this.correct,
      required this.incorrect,
      required this.total})
      : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.correct}/${widget.total}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 14,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow.shade900,
                  elevation: 10,
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => HomePage())));
              },
              child: Text(
                "Go to Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )),
      ),
    );
  }
}
