import 'answer_model.dart';

class Question {
  String? id;
  String? sectionId;
  String? formId;
  int? seq;
  String? question;
  String? description;
  String? type;
  String? correctAnswer;
  List<Answer>? answers;
  dynamic answer;
  int? dayNumber;

  Question(
      {this.id,
      this.sectionId,
      this.formId,
      this.seq,
      this.question,
      this.description,
      this.type,
      this.correctAnswer,
      this.answers,
      this.answer,
      this.dayNumber});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      id: json['id'],
      sectionId: json['sectionId'],
      formId: json['formId'],
      seq: json['seq'],
      question: json['question'],
      description: json['description'],
      type: json['type'],
      correctAnswer: json['correctAnswer'],
      answers: (json['Answers'] as List)
          .map((model) => Answer.fromJson(model))
          .toList());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["dayNumber"] = dayNumber;
    data["questionId"] = id;
    data["answer"] = answer;

    return data;
  }
}
