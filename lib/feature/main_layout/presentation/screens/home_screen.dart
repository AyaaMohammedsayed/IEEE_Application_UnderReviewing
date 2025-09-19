import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/feature/committes/data/models/commitee_data.dart';
import 'package:ieee_app/feature/committes/data/models/committee.dart';
import 'package:ieee_app/feature/events/data/event_data.dart';
import 'package:ieee_app/feature/main_layout/presentation/widgets/committee_grid.dart';
import 'package:ieee_app/feature/main_layout/presentation/widgets/event_grid.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

import '../widgets/custom_sponsor_widget.dart';
import '../../../../core/widgets/get_in_touch.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final allCommittees = [
    ...technicalCommittees,
    ...nonTechnicalCommittees,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        resizeToAvoidBottomInset: true,
        drawer: _drawerBody(context),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          title: Text(
            'Welcome to IEEE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 7.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(),
              SizedBox(height: 35.h),
              CommitteeSection(committees: allCommittees),
              SizedBox(height: 30.h),
              EventSection(events: dataEvents),
              SizedBox(height: 30.h),
              CustomSponsorWidget(),
              SizedBox(height: 30.h),
              GetInTouch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/IEEE_family/IEEE.jpeg"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black.withOpacity(0.35),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          "IEEE BU SB",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _drawerBody(BuildContext context) {
    return Drawer(
      width: 0.75.sw,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.pushNamed(Routes.profileScreen),
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage:
                        const AssetImage("assets/images/user.jpg"),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Profile',
                  style: TextStyles.fontSemi20Black.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.sp,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () => context.pushNamedAndRemoveUntil(
              Routes.homeScreen,
              predicate: (_) => true,
            ),
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'Committees',
            onTap: () => context.pushNamed(Routes.committeesScreen),
          ),
          _buildDrawerItem(
            icon: Icons.event,
            title: 'Events',
           onTap: () => context.pushNamed(Routes.eventScreen),
          ),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About Us',
            onTap: () => context.pushNamed(Routes.aboutUsScreen),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: TextStyles.fontSemi16Black),
      onTap: onTap,
    );
  }
}
