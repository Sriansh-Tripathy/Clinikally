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
              doctor.field, // Changed 'doctors' to 'doctor'
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
            ElevatedButton(onPressed: onPressed, child:const Text('book Appointment'),)
          ],
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialization;
  final String availability;

  Doctor({
    required this.name,
    required this.specialization,
    required this.availability,
  });
}
