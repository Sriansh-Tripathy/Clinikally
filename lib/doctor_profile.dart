import 'package:flutter/material.dart';
import 'package:onboard_animation/modals.dart';
import 'package:onboard_animation/dummy_data.dart';

UserProfile _userProfile = UserProfile();

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({required this.currentDoctor});
  final Doctors currentDoctor;
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
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
        title: Text('Doctor Profile'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          ProfileScreen(
            currentDoctor: widget.currentDoctor,
          ),
          ReportsScreen(
            currentDoctor: widget.currentDoctor,
          ),
          AppointmentsScreen(
            currentDoctor: widget.currentDoctor,
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wysiwyg_sharp),
          label: 'Reports', // Changed label to 'Reports'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointments',
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

class ReportsScreen extends StatefulWidget {
  final Doctors currentDoctor;

  const ReportsScreen({required this.currentDoctor});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Reports> doctorReports = [];

  @override
  void initState() {
    super.initState();
    // Filter reports associated with the current doctor
    doctorReports = reports
        .where((report) => report.rDoctorName == widget.currentDoctor.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: ListView.builder(
        itemCount: doctorReports.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          doctorReports[index].name, // Use report's name
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Age: ${doctorReports[index].age}', // Use report's age
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Blood Group: ${doctorReports[index].rBloodGrp}', // Use report's blood group
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Complications: ${doctorReports[index].complications}', // Use report's complications
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Remarks: ${doctorReports[index].remarks}', // Use report's remarks
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  final Doctors currentDoctor;

  const AppointmentsScreen({required this.currentDoctor});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late List<Apppointments> doctorAppointments;

  @override
  void initState() {
    super.initState();
    // Filter appointments associated with the current doctor
    doctorAppointments = appointments
        .where((appointment) =>
            appointment.aDoctorName == widget.currentDoctor.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                'Appointments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: doctorAppointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    appointmentData: doctorAppointments[index],
                    currentdoctor: widget.currentDoctor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Apppointments appointmentData;
  final Doctors currentdoctor;

  const AppointmentCard(
      {required this.appointmentData, required this.currentdoctor});

  Future<void> _showEditDialog(BuildContext context) async {
    TextEditingController medicationController = TextEditingController();
    TextEditingController dosageController = TextEditingController();
    TextEditingController complicationsController = TextEditingController();
    TextEditingController remarksController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Appointment Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: medicationController,
                  decoration: InputDecoration(labelText: 'Medication'),
                ),
                TextFormField(
                  controller: dosageController,
                  decoration: InputDecoration(labelText: 'Dosage'),
                ),
                TextFormField(
                  controller: complicationsController,
                  decoration: InputDecoration(labelText: 'Complications'),
                ),
                TextFormField(
                  controller: remarksController,
                  decoration: InputDecoration(labelText: 'Remarks'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here you can use the entered data from controllers
                String medication = medicationController.text;
                String dosage = dosageController.text;
                String complications = complicationsController.text;
                String remarks = remarksController.text;

                Patients? _currentPatient = registeredPatients.firstWhere(
                    (patient) => patient.name == appointmentData.aPatientName);

                Reports newReport = Reports(
                    age: _currentPatient.age,
                    complications: complications,
                    name: _currentPatient.name,
                    rBloodGrp: _currentPatient.bloodGrp,
                    remarks: remarks,
                    rDoctorName: currentdoctor.name);

                Prescription newPrescription = Prescription(
                    pDate: appointmentData.aDate,
                    pDoctorName: currentdoctor.name,
                    dosage: dosage,
                    medication: medication,
                    pPatientName: _currentPatient.name);

                prescriptions.add(newPrescription);
                reports.add(newReport);
                // Perform actions with the entered data, such as updating the appointment details
                // For demonstration purposes, print the entered data
                print('Medication: $medication');
                print('Dosage: $dosage');
                print('Complications: $complications');
                print('Remarks: $remarks');

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEditDialog(context);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${appointmentData.aDate}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Time: ${appointmentData.time}'),
              const SizedBox(height: 8),
              Text('Patient: ${appointmentData.aPatientName}'),
              const SizedBox(height: 8),
              Text('Reason: ${appointmentData.reason}'),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final Doctors currentDoctor;

  const ProfileScreen({required this.currentDoctor});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
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
              itemProfile('Name', widget.currentDoctor.name, Icons.person),
              const SizedBox(height: 10),
              itemProfile('Doctor Id', widget.currentDoctor.doctorId,
                  Icons.assignment_ind),
              const SizedBox(height: 10),
              itemProfile('Technical Language', widget.currentDoctor.field,
                  Icons.drive_file_rename_outline_sharp),
              const SizedBox(height: 10),
              itemProfile('Email', widget.currentDoctor.availability,
                  Icons.timelapse_sharp),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final updatedProfile = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        currentDoctor: widget.currentDoctor,
                      ),
                    ),
                  );

                  // Update userProfile with the changes
                  // if (updatedProfile != null) {
                  //   // Assuming userProfile is mutable
                  //   setState(() {
                  //     userProfile = updatedProfile;
                  //   });
                  // }
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
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
              blurRadius: 10)
        ]),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
      trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
      tileColor: Colors.white,
    ),
  );
}

// Dummy UserProfile class for demonstration
class UserProfile {
  String studentname = 'John Doe';
  String contactnumber = '+1234567890';
  String technicallanguages = 'Dart, Flutter';
  String email = 'john.doe@example.com';
  String linkedinid = 'john_doe_linkedin';
}

class EditProfileScreen extends StatefulWidget {
  final Doctors currentDoctor;

  const EditProfileScreen({required this.currentDoctor});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Edit Profile Screen'),
      ),
    );
  }
}
