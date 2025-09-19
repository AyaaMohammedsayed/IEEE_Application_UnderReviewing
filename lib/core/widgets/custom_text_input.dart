import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;


   const CustomTextInput(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.controller,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xff7C7D82),

          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Color(0xffBCBDC0),

            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 202, 201, 201),
                width: 0.2.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.w,
              ),
            ),
    
          ),
        )
      ],
    );
  }
}
