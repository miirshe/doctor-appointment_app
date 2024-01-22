class DoctorScheduleModel {
  late String id;
  late String day;
  late String date;
  late String from_time;
  late String to_time;
  late String doc_id;
  late String appointment_limit;
  late String status;


  DoctorScheduleModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    date = json['date'];
    day = json['day'];
    from_time = json['from_time'];
    to_time = json['to_time'];
    doc_id = json['doc_id'];
    appointment_limit = json['appointment_limit'];
    status = json['status'];
  }
}