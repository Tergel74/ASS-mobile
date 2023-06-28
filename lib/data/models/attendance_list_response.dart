class AttendanceListResponse {
  String? status;
  String? date;
  String? eventName;
  String? lesson;
  String? startTime;
  String? endTime;

  AttendanceListResponse(
      {this.status,
      this.date,
      this.eventName,
      this.lesson,
      this.startTime,
      this.endTime});

  AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    lesson = json['Event']['Lesson']['lessonName'];
    eventName = json['Event']['eventName'];
    startTime = json['Event']['EventDate']['startTime'];
    endTime = json['Event']['EventDate']['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;

    return data;
  }
}
