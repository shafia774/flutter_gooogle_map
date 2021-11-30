import 'dart:convert';

List<Listmodel> listsFromJson(data) {
  if (null != data)
    return List<Listmodel>.from(data.map((x) => Listmodel.fromJson(x)));

  return [];
}

String listsToJson(List<Listmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Listmodel {
  Listmodel({

    required this.bssid,
    required this.bssname,
    required this.latitude,
    required this.longitude,
    required this.opentime,
    required this.closetime,
  });

  String bssid;
  String bssname;
  String latitude;
  String longitude;
  DateTime opentime;
  DateTime closetime;

  factory Listmodel.fromJson(Map<String, dynamic> json) => Listmodel(
    bssid: json["BSSID"],
    bssname: json["BSSNAME"],
    latitude: json["LATITUDE"],
    longitude: json["LONGITUDE"],
    opentime: DateTime.parse(json["OPENTIME"]),
    closetime: DateTime.parse(json["CLOSETIME"]),
  );

  Map<String, dynamic> toJson() => {
    "BSSID": bssid,
    "BSSNAME": bssname,
    "LATITUDE": latitude,
    "LONGITUDE": longitude,
    "OPENTIME": opentime.toIso8601String(),
    "CLOSETIME": closetime.toIso8601String(),
  };
}
