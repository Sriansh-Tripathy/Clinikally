import 'package:flutter/material.dart';
import 'package:onboard_animation/modals.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: ListView.builder(
        itemCount: 5, // Assuming you have 5 patient reports
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
                      color:
                          Colors.blueAccent, // Change to your preferred color
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
                          'John Doe', // Replace with dynamic data
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
                          'Age: 30', // Replace with dynamic data
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Blood Group: O+', // Replace with dynamic data
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Complications: None', // Replace with dynamic data
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Remarks: Regular checkup', // Replace with dynamic data
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
  // Dummy appointment data
  List<Map<String, String>> appointments = [
    {
      'date': '2024-04-20',
      'time': '09:00 AM',
      'doctor': 'Dr. Smith',
      'reason': 'General Checkup',
    },
    {
      'date': '2024-05-15',
      'time': '02:30 PM',
      'doctor': 'Dr. Johnson',
      'reason': 'Dental Checkup',
    },
    // Add more appointments as needed
  ];

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
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(appointmentData: appointments[index]);
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
  final Map<String, String> appointmentData;

  const AppointmentCard({required this.appointmentData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${appointmentData['date']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Time: ${appointmentData['time']}'),
            const SizedBox(height: 8),
            Text('Doctor: ${appointmentData['doctor']}'),
            const SizedBox(height: 8),
            Text('Reason: ${appointmentData['reason']}'),
          ],
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