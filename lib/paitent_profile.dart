import 'package:flutter/material.dart';
import 'package:onboard_animation/modals.dart';

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
          PatientProfilePage(),
          PatientDoctorsPage(),
          PatientPrescriptionsPage(),
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
            itemProfile('Name', 'John Doe', Icons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', '+1234567890', Icons.phone),
            const SizedBox(height: 10),
            itemProfile(
                'Technical Language', 'Dart, Flutter', Icons.location_city),
            const SizedBox(height: 10),
            itemProfile('Email', 'john.doe@example.com', Icons.mail),
            const SizedBox(height: 20),
            itemProfile('LinkedIn', 'john_doe_linkedin', Icons.data_array),
            const SizedBox(height: 20),
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
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: doctors[index]);
      },
    );
  }
}

class PatientPrescriptionsPage extends StatefulWidget {
  @override
  _PatientPrescriptionsPageState createState() =>
      _PatientPrescriptionsPageState();
}

class _PatientPrescriptionsPageState extends State<PatientPrescriptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Prescriptions'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          return PrescriptionCard(prescription: prescriptions[index]);
        },
      ),
    );
  }
}

List<Prescription> prescriptions = [
  Prescription(
      date: '2024-04-20',
      doctor: 'Dr. Smith',
      medication: 'Medicine A',
      dosage: '1 tablet, once daily'),
  Prescription(
      date: '2024-05-15',
      doctor: 'Dr. Johnson',
      medication: 'Medicine B',
      dosage: '2 tablets, twice daily'),
  // Add more prescriptions as needed
];

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
              'Date: ${prescription.date}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Doctor: ${prescription.doctor}'),
            SizedBox(height: 8),
            Text('Medication: ${prescription.medication}'),
            SizedBox(height: 8),
            Text('Dosage: ${prescription.dosage}'),
          ],
        ),
      ),
    );
  }
}

class Prescription {
  final String date;
  final String doctor;
  final String medication;
  final String dosage;

  Prescription({
    required this.date,
    required this.doctor,
    required this.medication,
    required this.dosage,
  });
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
  final Doctor doctor;

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
              doctor.specialization,
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

List<Doctor> doctors = [
  Doctor(
    name: 'Dr. John Doe',
    specialization: 'Cardiologist',
    availability: 'Mon - Fri, 9:00 AM - 5:00 PM',
  ),
  Doctor(
    name: 'Dr. Jane Smith',
    specialization: 'Pediatrician',
    availability: 'Mon - Sat, 8:00 AM - 6:00 PM',
  ),
  Doctor(
    name: 'Dr. Michael Johnson',
    specialization: 'Dermatologist',
    availability: 'Tue - Fri, 10:00 AM - 4:00 PM',
  ),
  Doctor(
    name: 'Dr. Emily Williams',
    specialization: 'Orthopedic Surgeon',
    availability: 'Mon - Thu, 9:00 AM - 3:00 PM',
  ),
  Doctor(
    name: 'Dr. David Brown',
    specialization: 'Neurologist',
    availability: 'Wed - Sat, 10:00 AM - 5:00 PM',
  ),
];
