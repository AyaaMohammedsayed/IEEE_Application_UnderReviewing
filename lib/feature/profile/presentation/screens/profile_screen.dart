import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/core/widgets/get_in_touch.dart';
import 'package:ieee_app/feature/committes/data/models/HB_data.dart';
import 'package:ieee_app/feature/committes/data/models/best_members.dart';
import 'package:ieee_app/feature/committes/data/models/leaders_data.dart';
import 'package:ieee_app/feature/committes/data/models/member_model.dart';
import 'package:ieee_app/feature/committes/data/models/vice_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/decorated_container.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    final allMembers = [
      ...communityHBData,
      ...communityViceData,
      ...communitybestMembersData,
      ...communityLeadersData,
    ];

    final CommunityMemberModel userData = allMembers.firstWhere(
      (member) => member.email != null && member.email == currentUserEmail,
      orElse: () => CommunityMemberModel(
        email: currentUserEmail ?? '',
        name: currentUserEmail?.split('@').first ?? 'Member',
        role: 'Member',
        imagePath: 'assets/images/user.jpg',
        section: '',
        faculty: '',
        experience: '',
        linkedIn: '',
      ),
    );
final bool isNewMember = !allMembers.any(
  (member) => member.email != null && member.email == currentUserEmail,
);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: isNewMember
    ? FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, Routes.joinUsScreen),
        icon: Icon(Icons.person_add_alt_1, color: AppColors.primary),
        label: Text(
          'Join Us',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    : null,

        appBar: _buildAppBar(),
        backgroundColor: AppColors.offWhite,
        
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileMainInfo(context: context, user: userData),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: DecoratedContainer(
                  height: 350.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcons(context, userData),
                      Divider(thickness: 0.6, color: AppColors.grey),
                      SizedBox(height: 30.h),
                      GetInTouch(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMainInfo({
    required BuildContext context,
    required CommunityMemberModel user,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45.r,
            backgroundImage: AssetImage(user.imagePath),
          ),
          SizedBox(height: 12.h),
          Text(
            user.name,
            style: TextStyles.fontBold24Black,
            textAlign: TextAlign.center,
          ),
          if (user.role.isNotEmpty)
            Text(
              user.role,
              style: TextStyles.fontRegular16Gray.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.primary,
              ),
            ),
          SizedBox(height: 16.h),
          Divider(thickness: 1, color: AppColors.lightGrey),
          SizedBox(height: 8.h),
          _buildInfoRow(Icons.school, user.faculty),
            SizedBox(height: 16.h),
          _buildInfoRow(Icons.apartment, user.section),
            SizedBox(height: 16.h),
          _buildInfoRow(Icons.work_outline, " ${user.experience}"),
        ],
      ),
    );
  }
PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 3,
    shadowColor: Colors.black.withOpacity(0.05),
    centerTitle: true,
    title: Text(
      "Profile",
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        letterSpacing: 1.2,
      ),
    ),

  );
}

  Widget _buildInfoRow(IconData icon, String text) {
    if (text.isEmpty) return SizedBox();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 20.r, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyles.fontRegular16Gray.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons(BuildContext context, CommunityMemberModel user) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (user.email.isNotEmpty)
            _buildIconButton(
              icon: Icons.email_outlined,
              onTap: () async {
                final Uri emailUri = Uri(scheme: 'mailto', path: user.email);
                await launchUrl(emailUri);
              },
            ),
          if (user.linkedIn.isNotEmpty)
            _buildIconButton(
              icon: Icons.link_outlined,
              onTap: () async {
                final url = Uri.parse(user.linkedIn);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.1),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24.r),
        ),
      ),
    );
  }

  Widget _buildMemberDialog(BuildContext context, CommunityMemberModel member) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 40, backgroundImage: AssetImage(member.imagePath)),
          SizedBox(height: 10),
          Text(member.name, style: TextStyles.fontBold18Black),
          Text(member.role, style: TextStyles.fontRegular16Gray),
          Divider(),
          if (member.email.isNotEmpty)
            ListTile(
              leading: Icon(Icons.email, color: AppColors.primary),
              title: Text(member.email, style: TextStyles.fontRegular16Gray),
            ),
          if (member.linkedIn.isNotEmpty)
            ListTile(
              leading: Icon(Icons.link, color: AppColors.primary),
              title: GestureDetector(
                onTap: () async {
                  final url = Uri.parse(member.linkedIn);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Text("LinkedIn Profile", style: TextStyle(color: Colors.blue)),
              ),
            ),
        ],
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
