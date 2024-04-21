import 'package:flutter/material.dart';
import 'package:onboard_animation/modals.dart';
import 'package:onboard_animation/dummy_data.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({required this.currentPatient});
  final Patients currentPatient;
  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _onPageChanged(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          PatientProfilePage(
            currentPatient: widget.currentPatient,
          ),
          PatientDoctorsPage(
            currentPatient: widget.currentPatient,
          ),
          PatientPrescriptionsPage(
            currentPatient: widget.currentPatient,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        pageController: _pageController,
        onPageChanged: _onPageChanged,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class BottomNavBar extends StatefulWidget {
  final PageController? pageController;
  final ValueChanged<int> onPageChanged;

  BottomNavBar({
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.pageController?.page?.round() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt),
          label: 'Doctors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Prescriptions',
        ),
      ],
      onTap: (index) {
        widget.onPageChanged(index);
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({required this.currentPatient});
  final Patients currentPatient;
  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', widget.currentPatient.name, Icons.person),
            const SizedBox(height: 10),
            itemProfile('Age', widget.currentPatient.age, Icons.person),
            const SizedBox(height: 10),
            itemProfile(
                'Address', widget.currentPatient.address, Icons.location_city),
            const SizedBox(height: 10),
            itemProfile('Blood Group', widget.currentPatient.bloodGrp,
                Icons.local_hospital),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Navigate to edit profile screen
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientDoctorsPage extends StatefulWidget {
  const PatientDoctorsPage({required this.currentPatient});
  final Patients currentPatient;
  @override
  _PatientDoctorsPageState createState() => _PatientDoctorsPageState();
}

class _PatientDoctorsPageState extends State<PatientDoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: registerDoctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: registerDoctors[index]);
      },
    );
  }
}

class PatientPrescriptionsPage extends StatefulWidget {
  const PatientPrescriptionsPage({required this.currentPatient});
  final Patients currentPatient;
  @override
  _PatientPrescriptionsPageState createState() =>
      _PatientPrescriptionsPageState();
}

class _PatientPrescriptionsPageState extends State<PatientPrescriptionsPage> {
  late List<Prescription> patientPrescriptions;

  @override
  void initState() {
    super.initState();
    patientPrescriptions = prescriptions
        .where((prescription) =>
            prescription.pPatientName == widget.currentPatient.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Prescriptions'),
      ),
      body: ListView.builder(
        itemCount: patientPrescriptions.length,
        itemBuilder: (context, index) {
          return PrescriptionCard(prescription: patientPrescriptions[index]);
        },
      ),
    );
  }
}

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionCard({required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${prescription.pDoctorName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Medication: ${prescription.medication}'),
            SizedBox(height: 8),
            Text('Dosage: ${prescription.dosage}'),
            SizedBox(height: 8),
            Text('Dosage: ${prescription.dosage}'),
          ],
        ),
      ),
    );
  }
}

Widget itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 5),
          color: Colors.deepOrange.withOpacity(.2),
          spreadRadius: 2,
          blurRadius: 10,
        ),
      ],
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
      trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
      tileColor: Colors.white,
    ),
  );
}

class DoctorCard extends StatelessWidget {
  final Doctors doctor;

  const DoctorCard({required this.doctor});

  Future<void> bookAppointment(BuildContext context) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // Show a dialog with date and time pickers
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Date and Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Date picker
              ListTile(
                title: Text('Date:'),
                trailing: OutlinedButton(
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                  child: Text(selectedDate?.toString() ?? 'Select Date'),
                ),
              ),
              // Time picker
              ListTile(
                title: Text('Time:'),
                trailing: OutlinedButton(
                  onPressed: () async {
                    selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: Text(selectedTime?.toString() ?? 'Select Time'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Check if both date and time are selected
                if (selectedDate != null && selectedTime != null) {
                  // Generate a new appointment with selected date and time
                  final newAppointment = Apppointments(
                    aDate:
                        '${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}',
                    aDoctorName: doctor.name,
                    reason: 'Regular Checkup',
                    time: selectedTime?.format(context) ?? '',
                    aPatientName: 'Patient Name',
                  );

                  // Add the new appointment to the appointments list
                  appointments.add(newAppointment);

                  // Show a confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Appointment Booked'),
                        content: Text('Your appointment has been booked.'),
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
                } else {
                  // Show an error message if date or time is not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select both date and time.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Book Appointment'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              doctor.field,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Availability: ${doctor.availability}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            ElevatedButton(
              onPressed: () => bookAppointment(context),
              child: const Text('Book Appointment'),
            )
          ],
        ),
      ),
    );
  }
}
