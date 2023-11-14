class task {
  late String id;
  late String title;
  late String description;
  late String date;
 
  task(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
    
      }
      
      );

  task.fromjson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    title = json["title"] ?? "";
    description = json["description"] ?? "";
    date = json['date'] ?? "";
  }
  Map<String, dynamic> tojson() {
    final data = Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["date"] = date;
    return data;
  }
}
