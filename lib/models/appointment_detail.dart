class AppointmentDetailModel {
  late String appointment_id,
      doctor_fname,
      doctor_lname,
      doctor_address,
      doctor_speciality,
      doctor_status,
      doctor_id,
      doctor_image,
      day,
      date,
      time,
      patient_id,
      appointment_status;

  AppointmentDetailModel.fromJson(Map<String, dynamic> json) {
    appointment_id = json['appointment_id'];
    doctor_fname = json['doctor_fname'];
    doctor_lname = json['doctor_lname'];
    doctor_address = json['doctor_address'];
    doctor_speciality = json['doctor_speciality'];
    doctor_status = json['doctor_status'];
    doctor_id = json['doctor_id'];
    doctor_image = json['doctor_image'];
    date = json['date'];
    day = json['day'];
    time = json['time'];
    patient_id = json['patient_id'];
    appointment_status = json['appointment_status'];
  }
}
