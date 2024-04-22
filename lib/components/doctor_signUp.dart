import 'package:flutter/material.dart';
import 'package:onboard_animation/doctor_profile.dart';
import 'package:onboard_animation/paitent_profile.dart';
import 'package:onboard_animation/dummy_data.dart';
import 'package:onboard_animation/modals.dart';

class DoctorSignUp extends StatelessWidget {
  DoctorSignUp({Key? key}) : super(key: key);
  final _nameEtc = TextEditingController();
  final _passwordEtc = TextEditingController();
  final _fieldEtc = TextEditingController();
  final _doctorIdEtc = TextEditingController();
  final _avaialbilityEtc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an Doctor's account",
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
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: false,
                    controller: _fieldEtc,
                    decoration: InputDecoration(
                      hintText: "Field",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.wysiwyg_outlined,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: false,
                    controller: _doctorIdEtc,
                    decoration: InputDecoration(
                      hintText: "DoctorId",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.web_sharp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: false,
                    controller: _avaialbilityEtc,
                    decoration: InputDecoration(
                      hintText: "Availability",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.timelapse_sharp,
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
                  String _password = _passwordEtc.text;
                  String _field = _fieldEtc.text;
                  String _doctorId = _doctorIdEtc.text;
                  String _availability = _avaialbilityEtc.text;
                  Doctors newDoctor = Doctors(
                      name: _name,
                      field: _field,
                      doctorId: _doctorId,
                      password: _password,
                      availability: _availability);

                  // Check if a doctor with the entered name and password exists
                  if (_name != '' &&
                      _password != '' &&
                      _field != '' &&
                      _doctorId != '' &&
                      _availability != '') {
                    registerDoctors.add(newDoctor);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorProfileScreen(
                          currentDoctor: newDoctor,
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
