import 'package:flutter/material.dart';
import 'package:onboard_animation/components/doctor_signUp.dart';
import 'package:onboard_animation/components/landed_content.dart';
import 'package:onboard_animation/components/patientSignUp.dart';
import 'package:onboard_animation/components/sing_up_form.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late PageController _pageController;
  // double _progress;
  var _currentPage = 0;
  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  Widget callText() {
    switch (_currentPage) {
      case 0:
        return const Text('Get Started'); // Width for page 1
      case 1:
        return const Text(
          "Create account",
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ); // Width for page 2
      case 2:
        return const Text(
          "Are you a Patient?",
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ); // Width for page 3
      case 3:
        return const Text(
          "Are you a Doctor?",
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ); // Width for page 4
      default:
        return const Text('overflow'); // Default width
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0;

    return SizedBox(
      height: 400 + progress * 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    LandingContent(),
                    SignUpForm(),
                    DoctorSignUp(),
                    PatientSignUp(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            height: 56,
            bottom: 48,
            right: 16,
            child: GestureDetector(
              onTap: () {
                if (_pageController.page != 3) {
                  _pageController.animateToPage(++_currentPage,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                } else {
                  _pageController.animateToPage(--_currentPage,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.8],
                    colors: [
                      Color.fromARGB(255, 239, 104, 80),
                      Color.fromARGB(255, 139, 33, 146)
                    ],
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 92 + progress * 32,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            FadeTransition(
                              opacity: AlwaysStoppedAnimation(
                                  progress < 0.33 ? 1 : 0),
                              child: callText(),
                            ),
                            FadeTransition(
                                opacity: AlwaysStoppedAnimation(
                                    progress > 0.33 && progress < 0.67 ? 1 : 0),
                                child: callText()),
                            FadeTransition(
                              opacity: AlwaysStoppedAnimation(
                                  progress > 0.67 && progress < 0.99 ? 1 : 0),
                              child: callText(),
                            ),
                            FadeTransition(
                              opacity: AlwaysStoppedAnimation(
                                  progress >= 0.99 ? 1 : 0),
                              child: callText(),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
