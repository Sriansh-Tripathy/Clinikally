import 'package:flutter/material.dart';
import 'package:onboard_animation/doctor_profile.dart';
import 'package:onboard_animation/paitent_profile.dart';
import 'package:onboard_animation/dummy_data.dart';
import 'package:onboard_animation/modals.dart';

class PatientSignUp extends StatelessWidget {
  PatientSignUp({Key? key}) : super(key: key);
  final _nameEtc = TextEditingController();
  final _adhaarIdEtc = TextEditingController();
  final _ageEtc = TextEditingController();
  final _bloodGrpEtc = TextEditingController();
  final _addressEtc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an Patient account",
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
                    controller: _adhaarIdEtc,
                    decoration: InputDecoration(
                      hintText: "AdhaarId",
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
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    controller: _ageEtc,
                    decoration: InputDecoration(
                      hintText: "Age",
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
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    controller: _bloodGrpEtc,
                    decoration: InputDecoration(
                      hintText: "Blood Group",
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
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    controller: _addressEtc,
                    decoration: InputDecoration(
                      hintText: "Address",
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
                  String _name = _nameEtc.text;
                  String _adhaarId = _adhaarIdEtc.text;
                  String _age = _ageEtc.text;
                  String bloodGrp = _bloodGrpEtc.text;
                  String _address = _addressEtc.text;
                  Patients newPatient = Patients(
                      name: _name,
                      age: _age,
                      bloodGrp: bloodGrp,
                      adhaarId: _adhaarId,
                      address: _address);

                  // Check if a doctor with the entered name and password exists
                  if (_name != '' &&
                      _adhaarId != '' &&
                      _age != '' &&
                      bloodGrp != '' &&
                      _address != '') {
                    registeredPatients.add(newPatient);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientProfileScreen(
                          currentPatient: newPatient,
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
