import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/core/widgets/custom_text_input.dart';
import 'package:ieee_app/feature/Auth/Logic/google_sign_in_service.dart';
import 'package:ieee_app/feature/Auth/Logic/regitser_with_email.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      "assets/images/IEEE-BU-SB2 3 (1).png",
                      width: 400.w,
                      height: 200.h,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Create your new\n",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "account.",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextInput(
                  hintText: 'EmailAddress',
                  labelText: 'Emailaddress',
                  controller: emailController,
                ),
                SizedBox(height: 20.h),
                CustomTextInput(
                  hintText: 'Password',
                  labelText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 20.h),
                CustomTextInput(
                  hintText: 'ConfirmPassword',
                  labelText: 'Password',
                  controller: confirmController,
                  isPassword: true,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                    onPressed: () {
                      registerWithEmailPassword(context,emailController,passwordController,confirmController);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Text("  or continue with  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: 20.h),
                ElevatedButton.icon(
                  onPressed: () async {
                    final userCredential =
                        await GoogleSignInService.signInWithGoogle();
                    if (userCredential != null) {
                      context.pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        predicate: (route) => true,
                      );
                    
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Google Sign-In Failed")),
                      );
                    }
                  },
                  icon: Icon(FontAwesomeIcons.google, color: Colors.blueAccent),
                  label: Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
  onPressed: () => showLoginBottomSheet(context),
  child: Text(
    "Already have an account? Login",
    style: TextStyle(
      color: Colors.blue,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void showLoginBottomSheet(BuildContext context) {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20.w,
          right: 20.w,
          top: 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login to your account",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextInput(
              hintText: 'EmailAddress',
              labelText: 'Emailaddress',
              controller: loginEmailController,
            ),
            SizedBox(height: 10.h),
            CustomTextInput(
              hintText: 'Password',
              labelText: 'Password',
              controller: loginPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () async {
                final success = await loginWithEmailAndPassword(
                  context,
                  loginEmailController.text.trim(),
                  loginPasswordController.text.trim(),
                );
                if (success) {
                  Navigator.of(context).pop(); 
                  context.pushNamedAndRemoveUntil(Routes.homeScreen,
                      predicate: (route) => false);
                }
              },
              child: Text("Login",  style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    },
  );
}

}
