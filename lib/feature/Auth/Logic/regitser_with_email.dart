import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';

void registerWithEmailPassword(BuildContext context, dynamic emailController, dynamic passwordController, dynamic confirmController) async {
  final email = emailController.text.trim();
  final password = passwordController.text;
  final confirmPassword = confirmController.text;

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Passwords do not match")),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
     context.pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        predicate: (route) => true,
                      );
    // Navigate to next screen
  } on FirebaseAuthException catch (e) {
    String message = "An error occurred";
    if (e.code == 'email-already-in-use') {
      message = 'Email is already in use';
    } else if (e.code == 'weak-password') {
      message = 'The password is too weak';
    } else if (e.code == 'invalid-email') {
      message = 'Invalid email format';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


}
  Future<bool> loginWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: ${e.toString()}")),
    );
    return false;
  }
}