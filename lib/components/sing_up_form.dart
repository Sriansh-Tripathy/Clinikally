import 'package:flutter/material.dart';
import 'package:onboard_animation/doctor_profile.dart';
import 'package:onboard_animation/paitent_profile.dart';
import 'package:onboard_animation/dummy_data.dart';
import 'package:onboard_animation/modals.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);
  final _nameEtc = TextEditingController();
  final _passwordEtc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _nameEtc,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordEtc,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Retrieve name and password from form fields
                  String name = _nameEtc.text;
                  String password = _passwordEtc.text;
                  Doctors? currentDoctor = registerDoctors.firstWhere(
                    (doctors) => doctors.name == name,
                    orElse: () => const Doctors(
                      name: '',
                      field: '',
                      doctorId: '',
                      password: '',
                      availability: '',
                    ),
                  );
                  Patients? currentPatient = registeredPatients.firstWhere(
                      (patient) => patient.name == name,
                      orElse: () => const Patients(
                          adhaarId: '',
                          address: '',
                          age: '',
                          bloodGrp: '',
                          name: ''));
                  // Check if a doctor with the entered name and password exists
                  if (currentDoctor.name != '' &&
                      currentDoctor.password == password) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorProfileScreen(
                          currentDoctor: currentDoctor,
                        ),
                      ),
                    );
                  } else if (currentPatient.name != '' &&
                      currentPatient.adhaarId == password) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientProfileScreen(
                          currentPatient: currentPatient,
                        ),
                      ),
                    );
                  } else {
                    // Handle case where doctor doesn't exist (e.g., show error message)
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Invalid name or password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Already have an account? Sign in.",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
