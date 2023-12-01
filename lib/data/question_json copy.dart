import 'dart:convert';
import 'dart:io';
import 'package:quiz_application/models/quiz_question.dart';

List<QuizQuestion> questions = [];

List<QuizQuestion> getQuestions() {
  try {
   
    File file = File('lib/data/json/quiz_json.json');
    String jsonString = file.readAsStringSync();


    List<dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> decodedJson = json.decode(jsonString);

   questions = decodedJson.map((json) {
    return QuizQuestion(
      json['question'] as String,
      List<String>.from((json['answers'] as List<dynamic>).cast<String>()),
    );
  }).toList();

    
    print(jsonData);
  } catch (e) {
    print('Error reading file: $e');
  }
  
  

  return questions;
}
