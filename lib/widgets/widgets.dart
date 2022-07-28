import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 30),
        children: <TextSpan>[
          TextSpan(
              text: 'Quiz',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black54)),
          TextSpan(
              text: 'Maker',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.yellow.shade900)),
        ],
      ),
    ),
  );
}

Widget buildLogo() {
  final myLogo =
      'https://ps.w.org/quiz-maker/assets/icon-256x256.png?rev=2174282';

  return CircleAvatar(
    backgroundColor: Colors.white38,
    backgroundImage: NetworkImage(myLogo),
    radius: 100,
  );
}
