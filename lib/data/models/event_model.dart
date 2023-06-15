class Event {
  String? id;
  String? name;
  String? lesson;
  String? date;
  String? startTime;
  String? endTime;

  Event(
      {this.id,
      this.name,
      this.lesson,
      this.date,
      this.startTime,
      this.endTime});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['eventName'];
    lesson = json['lesson'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // (id != null) ? data["id"] = id : null;
    data["eventDate"] = date;

    return data;
  }
}
