import 'question_model.dart';

class Forms {
  String? id;
  String? typeId;
  String? description;
  String? name;
  String? status;
  int? duration;
  String? totalPoint;
  List<Question>? questions;
  List? questionsTo;
  String? quote;
  String? time;

  Forms(
      {this.id,
      this.typeId,
      this.description,
      this.name,
      this.status,
      this.duration,
      this.totalPoint,
      this.questions,
      this.questionsTo,
      this.quote,
      this.time});

  factory Forms.fromJson(Map<String, dynamic> json) => Forms(
      id: json['id'],
      typeId: json['typeId'],
      description: json['description'],
      name: json['name'],
      status: json['status'],
      duration: json['duration'],
      totalPoint: json['totalPoint'],
      questions: (json['Questions'] as List)
          .map((model) => Question.fromJson(model))
          .toList(),
      quote: json['UserForms'][0]['quote'],
      time: json['UserForms'][0]['createdAt']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // (id != null) ? data["id"] = id : null;
    data["formId"] = id;
    data['Questions'] = questionsTo;

    return data;
  }
}
