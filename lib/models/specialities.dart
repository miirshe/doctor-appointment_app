class SpecialitiesModel {
  late String speciality;
  late String image;

  SpecialitiesModel.fromJson(Map<String, dynamic> json) {
    speciality = json['speciality'];
    image = json['image'];
  }
}
