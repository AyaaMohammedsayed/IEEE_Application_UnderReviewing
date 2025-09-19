import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class GetInTouch extends StatelessWidget {
  const GetInTouch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary, // خلفية أزرق غامق
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get In Touch",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),
          _buildIconWithTitle(
            title: "Shoubra Faculty of Engineering",
            icon: Icons.location_on,
            color: Colors.white,
          ),
          SizedBox(height: 8.h),
          _buildIconWithTitle(
            title: "ieeebusbofficial@gmail.com",
            icon: Icons.email,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Row(
          
            children: [
              _buildSocialInfoItem(
                icon: Icons.link,
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      'https://ieee-busb24-website.vercel.app'));
                },
              ),
              SizedBox(width: 10.w,),
              _buildSocialInfoItem(
                icon: FontAwesomeIcons.facebook,
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      'https://www.facebook.com/share/1FA4Yep9py/'));
                },
              ),
                   SizedBox(width: 10.w,),
              _buildSocialInfoItem(
                icon: FontAwesomeIcons.instagram,
                onPressed: () async {
                  await launchUrl(
                      Uri.parse('https://www.instagram.com/ieee_bu_sb/'));
                },
              ),
                   SizedBox(width: 10.w,),
              _buildSocialInfoItem(
                icon: FontAwesomeIcons.linkedinIn,
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      'https://www.linkedin.com/company/ieee-bu-sb/'));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconWithTitle({
    required String title,
    required IconData icon,
    Color color = Colors.white,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialInfoItem({
    required IconData icon,
    required Future<void> Function() onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.white.withOpacity(0.2),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 18.sp),
        onPressed: onPressed,
      ),
    );
  }
}
