class Answer {
  String? id;
  String? seq;
  String? answer;
  int? point;
  bool? isCorrect;
  String? questionId;

  Answer(
      {this.id,
      this.seq,
      this.answer,
      this.point,
      this.isCorrect,
      this.questionId});

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json['id'],
        seq: json['seq'],
        answer: json['answer'],
        point: json['point'],
        isCorrect: json['isCorrect'],
        questionId: json['questionId'],
      );
}
