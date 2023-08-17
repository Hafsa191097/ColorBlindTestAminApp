import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;


  Future<void> emailLogin(String email, String password , BuildContext context) async {
    
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

    Future<User?> emailLoginAdmin(String email, String pass) async {
    final usercredential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return usercredential.user;
  }

  
  Future<void> registerUser(String email, String password, BuildContext context) async {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}