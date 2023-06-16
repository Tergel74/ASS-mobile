class AttendanceResponse {
  int? all;
  int? unregistered;
  int? present;
  int? late;
  int? absent;
  int? excused;

  AttendanceResponse(
      {this.all,
      this.unregistered,
      this.present,
      this.late,
      this.absent,
      this.excused});

  AttendanceResponse.fromJson(Map<String, dynamic> json) {
    all = json['allCount'];
    unregistered = json['unregisteredCount'];
    present = json['presentCount'];
    late = json['lateCount'];
    absent = json['absentCount'];
    excused = json['excusedCount'];
  }
}
