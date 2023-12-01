import 'dart:convert';
import 'dart:io';
import 'package:quiz_application/models/quiz_question.dart';

List<QuizQuestion> questions = [];

List<QuizQuestion> getQuestions() {
  try {
    // Read the file
    File file = File('F:/ICET/ICM103/FLUTTER/quiz_application/lib/data/json/quiz_json.json');
    String jsonString = file.readAsStringSync();

    // Parse the contents (assuming it contains JSON in this example)
    List<dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> decodedJson = json.decode(jsonString);

   questions = decodedJson.map((json) {
    return QuizQuestion(
      json['question'] as String,
      List<String>.from((json['answers'] as List<dynamic>).cast<String>()),
    );
  }).toList();

    // Use the data as needed
    print(jsonData);
  } catch (e) {
    print('Error reading file: $e');
  }
  
  

  return questions;
}
