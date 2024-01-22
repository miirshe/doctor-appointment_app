class DiagnosesModel {
  late String id;
  late String name;
  late String description;

  DiagnosesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
}
