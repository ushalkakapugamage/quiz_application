import 'package:flutter/material.dart';
import 'package:quiz_application/data/question_json copy.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {Key? key, required this.answerList, required this.onAction})
      : super(key: key);

  final List<String> answerList;
  final Function(String value) onAction;

  List<Map<String, Object>> getSummary() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < answerList.length; i++) {
      summary.add({
        'questionIndex': i,
        'question': getQuestions()[i].question,
        'correct_answer': getQuestions()[i].answers[0],
        'user_answer': answerList[i],
        'is_correct': getQuestions()[i].answers[0] == answerList[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var count = 0;
    var percentage = (count / getQuestions().length) * 100;
    var stat = "";

    for (int i = 0; i < getSummary().length; i++) {
      if (getSummary()[i]['is_correct'] as bool) {
        count++;
      }
    }
    if (percentage >= 90) {
      stat = "Excellent Work!";
    } else if (percentage >= 80) {
      stat = "Great Job!";
    } else if (percentage >= 70) {
      stat = "Good Effort!";
    } else if (percentage >= 60) {
      stat = "You're Making Progress!";
    } else if (percentage >= 50) {
      stat = "Keep Trying!";
    } else {
      stat = "Needs Improvement. Keep Going!";
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Result Screen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Correct Answer Count  $count",
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  stat,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...getSummary().map(
                          (s) => RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text:
                                      "${(s['questionIndex'] as int) + 1}.  ${(s['question'])}  ${s['is_correct'] as bool ? 'Correct' : 'Incorrect'}\n\n",
                                  style: TextStyle(
                                    color: s['is_correct'] as bool
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        " User Answer : \n${s['user_answer']}\n\n"
                                        "  Correct Answer : \n${s['correct_answer']}\n\n",
                                    style: const TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color.fromARGB(255, 72, 80, 97))),
                    onPressed: () {
                      onAction('start');
                    },
                    child: const Text(
                      'Restart',
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
