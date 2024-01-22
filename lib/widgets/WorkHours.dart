import 'package:doctor_appointments/CustomStyle.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:flutter/material.dart';

class WorkHours extends StatefulWidget {
  final DoctorScheduleModel? doctorScheduleModel;
  final String doc_id;

  const WorkHours(
      {super.key, required this.doctorScheduleModel, required this.doc_id});

  @override
  State<WorkHours> createState() => _WorkHoursState();
}

class _WorkHoursState extends State<WorkHours> {
  @override
  Widget build(BuildContext context) {
    return
      DataTable(
        columns: [
      DataColumn(label: Text('Day')),
      DataColumn(label: Text('From Time')),
      DataColumn(label: Text('To Time')),
    ], rows: [
      DataRow(cells:[
        DataCell(Text(widget.doc_id == widget.doctorScheduleModel!.doc_id ? widget.doctorScheduleModel!.day : ''),),
        DataCell(Text(widget.doc_id == widget.doctorScheduleModel!.doc_id ? widget.doctorScheduleModel!.from_time : ''),),
        DataCell(Text(widget.doc_id == widget.doctorScheduleModel!.doc_id ? widget.doctorScheduleModel!.to_time : ''),),

      ]),
    ]);
  }
}
