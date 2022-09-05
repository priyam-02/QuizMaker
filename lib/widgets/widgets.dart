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
  // final myLogo = Image.asset("assets/images/icon.png");
  // 'https://ps.w.org/quiz-maker/assets/icon-256x256.png?rev=2174282';

  return CircleAvatar(
    backgroundColor: Colors.white38,
    backgroundImage: AssetImage("assets/images/icon.png"),
    radius: 115,
  );
}

Widget orangeButton(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.yellow.shade900, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(
          color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );
}
