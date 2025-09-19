import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:ieee_app/core/widgets/custom_text_input.dart';
import 'package:ieee_app/feature/committes/data/models/commitee_data.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final collegeController = TextEditingController();
  final linkedinController = TextEditingController();
  String? selectedCommittee;

final List<String> committees = {
  ...technicalCommittees.map((e) => e.name),
  ...nonTechnicalCommittees.map((e) => e.name),
}.toList()
  ..sort();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Learn Today...Lead Tomorrow", style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CustomTextInput(
              labelText: "Full Name",
              controller: nameController,
              hintText: "FullName",
            ),
            SizedBox(height: 16.h),
            CustomTextInput(
              labelText: "Email",
              controller: emailController,
              hintText: "Email",
            ),
            SizedBox(height: 16.h),
            CustomTextInput(
              labelText: "WhatsApp Number",
              controller: phoneController,
              hintText: "WhatsApp Number",
            ),
            SizedBox(height: 16.h),
            CustomTextInput(
              labelText: "College",
              controller: collegeController,
                  hintText: "College",
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<String>(
              value: selectedCommittee,
              decoration: InputDecoration(
                labelText: 'Committee',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              items: committees .map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (val) {
                setState(() => selectedCommittee = val);
              },
            ),
            SizedBox(height: 16.h),
            CustomTextInput(
              labelText: "LinkedIn Profile",
              controller: linkedinController,
               hintText: "LinkedIn Profile",
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
         onPressed: () async {
final name = nameController.text.trim();
final email = emailController.text.trim();
final phone = phoneController.text.trim();
final college = collegeController.text.trim();
final linkedin = linkedinController.text.trim();
final committee = selectedCommittee;

// Regular expression to validate email format
final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

// Check required fields
if (name.isEmpty || email.isEmpty || phone.isEmpty || college.isEmpty || committee == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Please fill all required fields')),
  );
  return;
}

// Check email format
if (!emailRegex.hasMatch(email)) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Please enter a valid email address')),
  );
  return;
}

// Check phone is numeric and exactly 11 digits
if (phone.length != 11 || int.tryParse(phone) == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Phone number must be 11 digits')),
  );
  return;
}


  try {
    await FirebaseFirestore.instance.collection('join_requests').add({
      'name': name,
      'email': email,
      'phone': phone,
      'college': college,
      'linkedin': linkedin,
      'committee': committee,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Thank you! We'll contact you soon 💙")),
    );

    // Clear the form
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    collegeController.clear();
    linkedinController.clear();
    setState(() {
      selectedCommittee = null;
    });

    // Navigate back or stay
    // Navigator.pop(context);

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong. Please try again")),
    );
  }
},

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
