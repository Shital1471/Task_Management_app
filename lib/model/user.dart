class users {
  late String title;
  late String time;
  late int length;
  users({required this.title, required this.time,required this.length});

  users.fromjson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    time = json['time'] ?? "";
    length=json["length"]??0;
  
  }
  Map<String, dynamic> tojson() {
    final data = Map<String, dynamic>();
    data["title"] = title;
    data["time"] = time;
    return data;
  }
}
