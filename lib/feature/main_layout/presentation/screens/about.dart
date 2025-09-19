import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:ieee_app/core/constants/app_images.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/feature/committes/data/models/leaders_data.dart';
import 'package:ieee_app/feature/committes/data/models/member_model.dart';
import 'package:ieee_app/feature/main_layout/presentation/widgets/custom_sponsor_widget.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About IEEE BU SB", style:TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                alignment: Alignment.bottomLeft,
                height: 200.h,
                width: 340.w,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/IEEE_family/About .jpeg"),
            fit: BoxFit.fill,
          ),
                ),
              ),
                SizedBox(height: 20.h),
                Text("IEEE BU SB",
                    style: TextStyles.fontBold26White.copyWith(color: AppColors.primary)),
                SizedBox(height: 10.h),
                Text(
                  "IEEE Benha University Student Branch is part of the world’s largest professional organization for the advancement of technology. Our goal is to empower students through technical and non-technical activities.",
                  textAlign: TextAlign.center,
                  style: TextStyles.fontRegular16Gray,
                ),
                SizedBox(height: 20.h),
                Divider(),
                // Officers Section
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Officers",
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: communityLeadersData.map((member) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: _boardCard(
                context: context,
                member: member,
              ),
            );
          }).toList(),
        ),
      ),
    ],
  ),
),
const SizedBox(height: 30),

                Divider(),
          Text("Our Sponsors", style: TextStyles.fontBold18Black),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
         SponsorGrid()
              ],
            ),
          ),
SizedBox(height: 30.h),
Container(
  width: MediaQuery.of(context).size.width,
  color: AppColors.primary,
  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _socialIcon(FontAwesomeIcons.facebook,
              'https://www.facebook.com/share/1FA4Yep9py/'),
          SizedBox(width: 16.w),
          _socialIcon(FontAwesomeIcons.instagram,
              'https://www.instagram.com/ieee_bu_sb/'),
          SizedBox(width: 16.w),
          _socialIcon(FontAwesomeIcons.linkedinIn,
              'https://www.linkedin.com/company/ieee-bu-sb/'),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.email, color: Colors.white, size: 16.sp),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              "ieeebusbofficial@gmail.com",
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      SizedBox(height: 8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: Colors.white, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            "Shoubra Faculty of Engineering",
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
          ),
        ],
      ),
    ],
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _socialIcon(IconData icon, String url) {
  return InkWell(
    onTap: () async => await launchUrl(Uri.parse(url)),
    child: CircleAvatar(
      radius: 18.r,
      backgroundColor: Colors.white.withOpacity(0.2),
      child: Icon(icon, color: Colors.white, size: 18.sp),
    ),
  );
}
Widget _boardCard({
  required BuildContext context,
  required CommunityMemberModel member,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => _buildMemberDialog(context, member),
          );
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.primary,
          child: CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage(member.imagePath),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(member.name, style: TextStyles.fontSemi16Black),
      Text(member.role, style: TextStyles.fontRegular16Gray),
    ],
  );
}
Widget _buildMemberDialog(BuildContext context, CommunityMemberModel member) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    contentPadding: EdgeInsets.all(16),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(member.imagePath),
          ),
          SizedBox(height: 10),
          Text(member.name, style: TextStyles.fontBold18Black),
          Text(member.role, style: TextStyles.fontRegular16Gray),
          Divider(),
          if (member.email != null && member.email!.isNotEmpty)
            ListTile(
              leading: Icon(Icons.email, color: AppColors.primary),
              title: Text(member.email!, style: TextStyles.fontRegular16Gray),
            ),
          if (member.linkedIn != null && member.linkedIn!.isNotEmpty)
            ListTile(
              leading: Icon(FontAwesomeIcons.linkedinIn,
                  color: AppColors.primary, size: 20),
              title: GestureDetector(
                onTap: () async {
                  final url = Uri.parse(member.linkedIn!);
                  await launchUrl(url);
                },
                child: Text("LinkedIn Profile",
                    style: TextStyle(color: Colors.blue)),
              ),
            ),
          if (member.experience.isNotEmpty)
            ListTile(
              leading: Icon(Icons.work, color: AppColors.primary),
              title: Text(member.experience,
                  style: TextStyles.fontRegular16Gray),
            ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("Close", style: TextStyle(color: AppColors.primary)),
      ),
    ],
  );
}

}
