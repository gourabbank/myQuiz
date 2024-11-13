import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb constant

void main() => runApp(MyQuizApp());

class MyQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyQuizScreen(),
    );
  }
}

class MyQuizScreen extends StatefulWidget {
  @override
  _MyQuizScreenState createState() => _MyQuizScreenState();
}

class _MyQuizScreenState extends State<MyQuizScreen> {
  // Nullable integers for random numbers in the expression
  int? num1;
  int? num2;

  // Variables for UI display and tracking game rounds
  int playCount = 0;
  String playButtonText = "Play";
  String expressionText = "Expression";
  String solutionText = "Solution";

  // Function to generate new expression when "Play" button is pressed
  void generateExpression() {
    setState(() {
      num1 = Random().nextInt(101); // Random number between 0 and 100
      num2 = Random().nextInt(101); // Random number between 0 and 100
      playCount++;
      expressionText = "$num1 + $num2";
      playButtonText = "Play Again";
      solutionText = "Solution"; // Reset solution text when playing again
    });
  }

  // Function to solve the expression and display the result
  void solveExpression() {
    setState(() {
      // Only update solution if both numbers are not null
      if (num1 != null && num2 != null) {
        solutionText = "${num1! + num2!}";
      }
      // If num1 or num2 is null, solutionText remains "Solution"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('myQuiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display for the expression
            Text(expressionText, style: TextStyle(fontSize: 24)),
            // Display for the solution
            Text(solutionText, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getPlayButton(),
                SizedBox(width: 10),
                getSolveButton(),
              ],
            ),
            SizedBox(height: 20),
            // Display for total rounds played
            Text("Total Counts: $playCount"),
          ],
        ),
      ),
    );
  }

  // Function to get the "Play/Play Again" button with platform compatibility
  Widget getPlayButton() {
    if (kIsWeb) {
      // Web-compatible button
      return ElevatedButton(
        onPressed: generateExpression,
        child: Text(playButtonText),
      );
    } else {
      return CupertinoButton(
        child: Text(playButtonText),
        onPressed: generateExpression,
      );
    }
  }

  // Function to get the "Solve" button with platform compatibility
  Widget getSolveButton() {
    if (kIsWeb) {
      // Web-compatible button
      return ElevatedButton(
        onPressed: solveExpression,
        child: Text("Solve"),
      );
    } else {
      return CupertinoButton(
        child: Text("Solve"),
        onPressed: solveExpression,
      );
    }
  }
}