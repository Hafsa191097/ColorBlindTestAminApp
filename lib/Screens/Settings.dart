import 'package:flutter/material.dart';

import '../Auth/auth.dart';
import 'Login_Signup/Login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            AuthService().signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
          backgroundColor: Colors.redAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child:
               const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
