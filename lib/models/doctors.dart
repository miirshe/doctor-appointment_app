class DoctorModel {
  late String id;
  late String fname;
  late String lname;
  late String email;
  late String gender;
  late String experience;
  late String phone;
  late String address;
  late String hos_id;
  late String speciality;
  late String status;
  late String description;
  late String image;
  late String created_at ;

  DoctorModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    gender = json['gender'];
    experience = json['experience'];
    phone = json['phone'];
    address = json['address'];
    hos_id = json['hos_id'];
    speciality = json['speciality'];
    status = json['status'];
    description = json['description'];
    image = json['image'];
    created_at = json['created_at'];
  }
}