import 'package:flutter/material.dart';
import 'package:quiz_application/data/question_json.dart';
import 'package:quiz_application/question_screen.dart';
import 'package:quiz_application/result_screen.dart';
import 'package:quiz_application/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String activeScreen = 'start';
  List<String> selectedAnswers = [];

  void onScreenChange(String value) {
    setState(() {
      activeScreen = value;
    });
  }

  void onAnswerSelect(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == getQuestions().length) {
      setState(() {
        activeScreen = 'result';
      });
    }
  }

  void onRestart(String value) {
    setState(() {
      selectedAnswers = [];
      activeScreen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentScreen = StartScreen(onAction: onScreenChange);

    if (activeScreen == 'start') {
      currentScreen = StartScreen(onAction: onScreenChange);
    }

    if (activeScreen == 'quiz') {
      currentScreen =
          QuestionScreen(onAnswer: onAnswerSelect, onAction: onScreenChange);
    }

    if (activeScreen == 'result') {
      currentScreen =
          ResultScreen(onAction: onRestart, answerList: selectedAnswers);
    }

    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 19, 19, 19)
        ),
        child: currentScreen,
      )),
    );
  }
}
