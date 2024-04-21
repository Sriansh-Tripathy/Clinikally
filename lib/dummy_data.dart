import 'package:onboard_animation/modals.dart';
import 'package:flutter/material.dart';

var registerDoctors = [
  const Doctors(
      name: "Deepak Kumar Tripathy",
      field: "Gynacologist",
      doctorId: "12345",
      password: "iamdeepak",
      availability: "mon - sat 9am to 12pm and 4pm to 7pm"),
  const Doctors(
      name: "Priyadarshi Sahoo",
      field: "Anesthetic",
      doctorId: "23451",
      password: "iampriya",
      availability: "mon - thu 9am to 2pm"),
  const Doctors(
      name: "Jeetain Patel",
      field: "Surgeon",
      doctorId: "34512",
      password: "iamJeetain",
      availability: "mon - sat 9am to 12 pm and 3pm to 5pm"),
  const Doctors(
      name: "Dr Zia Ul Haque",
      field: "Medicine Speacialist",
      doctorId: "12345",
      password: "iamzia",
      availability: "mon - sat 9am to 12 pm and 4pm to 7pm"),
];

var registeredPatients = [
  const Patients(
      adhaarId: "1234567890",
      address: "cox colony",
      age: "30",
      bloodGrp: "A+",
      name: "Priya Jain"),
  const Patients(
      adhaarId: "2345678901",
      address: "Marwadi pada",
      age: "27",
      bloodGrp: "O+",
      name: "Swati Mishra"),
  const Patients(
      adhaarId: "3456789012",
      address: "BTM",
      age: "31",
      bloodGrp: "B+",
      name: "Radha Pandey"),
  const Patients(
      adhaarId: "4567890123",
      address: "Mangal Bazaar",
      age: "28",
      bloodGrp: "AB-",
      name: "Sneha Singh"),
];

var prescriptions = [
  const Prescription(
      pDate: "27-12-2023",
      pDoctorName: "Priyadarshi Sahoo",
      dosage: "once a day",
      medication: "motelucast",
      pPatientName: "Priya Jain"),
  const Prescription(
      pDate: "20-2-2024",
      pDoctorName: "Deepak Kumar Tripathy",
      dosage: "twice a day for 2 weeks",
      medication: "Setrizine",
      pPatientName: "Priya Jain"),
  const Prescription(
      pDate: "13-4-2024",
      pDoctorName: "Jeetain Patel",
      dosage: "twicwc a day",
      medication: "Betadine",
      pPatientName: "Sneha Singh"),
  const Prescription(
      pDate: "16-2-2024",
      pDoctorName: "Dr Zia Ul Haque",
      dosage: "once a day",
      medication: "Setracaonzole",
      pPatientName: "Swati Mishra"),
];
var appointments = [
  const Apppointments(
      aDate: "29-6-2024",
      aDoctorName: "Dr Zia Ul Haque",
      reason: "Regular CheckUp",
      time: "11am",
      aPatientName: "Swati Mishra"),
  const Apppointments(
      aDate: "12-5-2024",
      aDoctorName: "Deepak Kumar Tripathy",
      reason: "Regular CheckUp",
      time: "5pm",
      aPatientName: "Priya Jain"),
  const Apppointments(
      aDate: "29-6-2024",
      aDoctorName: "Deepak Kumar Tripathy",
      reason: "Regular CheckUp",
      time: "11am",
      aPatientName: "Radha Pandey"),
  const Apppointments(
      aDate: "7-6-2024",
      aDoctorName: "Deepak Kumar Tripathy",
      reason: "Regular CheckUp",
      time: "8am",
      aPatientName: "Sneha Singh"),
];

var reports = [
  const Reports(
    age: "",
    complications: "high blood Pressure",
    name: "Priya Jain",
    rBloodGrp: "A+",
    remarks: "3 months into Gestation",
    rDoctorName: "Deepak Kumar Tripathy",
  ),
  const Reports(
    age: "",
    complications: "None",
    name: "Swati Mishra",
    rBloodGrp: "O+",
    remarks: "7 months into Gestation",
    rDoctorName: "Deepak Kumar Tripathy",
  ),
  const Reports(
    age: "",
    complications: "None",
    name: "Sneha Singh",
    rBloodGrp: "AB-",
    remarks: "Normal recovery of surgery",
    rDoctorName: "Jeetain Patel",
  ),
  const Reports(
    age: "",
    complications: "Sebahoric Dermatitis",
    name: "Swati Mishra",
    rBloodGrp: "O+",
    remarks: "area of effect has been incresed",
    rDoctorName: "Dr Zia Ul Haque",
  ),
];
