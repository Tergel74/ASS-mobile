class Event {
  String? id;
  String? name;
  String? lesson;
  String? date;
  String? startTime;
  String? endTime;
  String? attendanceStatus;
  String? attendanceComment;

  Event(
      {this.id,
      this.name,
      this.lesson,
      this.date,
      this.startTime,
      this.endTime,
      this.attendanceStatus,
      this.attendanceComment});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['eventName'];
    lesson = json['lesson'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    attendanceStatus = json['attendanceStatus'];
    attendanceComment = json['attendanceComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // (id != null) ? data["id"] = id : null;
    data["eventDate"] = date;

    return data;
  }
}
