import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wewa/presentation/views/login_signup_pages/onboarding.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(child: ElevatedButton(onPressed: () {
        FlutterSecureStorage storage = FlutterSecureStorage();
        storage.deleteAll();
        Navigator.popUntil(context, (route) => false);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OnboardingScreen();
        },));
      },child: Text("LogOut")),),
    );
  }
}
