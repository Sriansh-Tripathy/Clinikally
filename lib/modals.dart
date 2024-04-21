import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Doctors {
  const Doctors(
      {required this.name,
      required this.field,
      required this.doctorId,
      required this.password,
      required this.availability});

  final String name;
  final String field;
  final String doctorId;
  final String password;
  final String availability;
}

class Patients {
  const Patients(
      {required this.adhaarId,
      required this.address,
      required this.age,
      required this.bloodGrp,
      required this.name});

  final String adhaarId;
  final String name;
  final String age;
  final String address;
  final String bloodGrp;
}

class Prescription {
  const Prescription(
      {required this.pDate,
      required this.pDoctorName,
      required this.dosage,
      required this.medication,
      required this.pPatientName});

  final String pDate;
  final String pDoctorName;
  final String medication;
  final String dosage;
  final String pPatientName;
}

class Apppointments {
  const Apppointments(
      {required this.aDate,
      required this.aDoctorName,
      required this.reason,
      required this.time,
      required this.aPatientName});

  final String aDate;
  final String time;
  final String aDoctorName;
  final String reason;
  final String aPatientName;
}

class Reports {
  const Reports({
    required this.age,
    required this.complications,
    required this.name,
    required this.rBloodGrp,
    required this.remarks,
    required this.rDoctorName,
  });

  final String age;
  final String name;
  final String rBloodGrp;
  final String complications;
  final String remarks;
  final String rDoctorName;
}
