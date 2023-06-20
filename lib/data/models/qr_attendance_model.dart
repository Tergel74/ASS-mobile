class QrAttendance {
  String? qrString;
  String? eventId;
  String? date;
  int? timeDifference;

  QrAttendance({this.qrString, this.eventId, this.date, this.timeDifference});

  QrAttendance.fromJson(Map<String, dynamic> json) {
    qrString = json['qrString'];
    eventId = json['eventId'];
    date = json['date'];
    timeDifference = json['timeDifference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // (id != null) ? data["id"] = id : null;
    data['qrString'] = qrString;
    data['eventId'] = eventId;
    data["date"] = date;
    data['timeDifference'] = timeDifference;

    return data;
  }
}
