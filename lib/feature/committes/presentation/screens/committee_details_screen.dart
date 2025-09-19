import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:ieee_app/core/constants/app_images.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/core/widgets/get_in_touch.dart';
import 'package:ieee_app/feature/committes/data/models/HB_data.dart';
import 'package:ieee_app/feature/committes/data/models/best_members.dart';
import 'package:ieee_app/feature/committes/data/models/member_model.dart';
import 'package:ieee_app/feature/committes/data/models/vice_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/commitee_data.dart';

class CommitteeDetailsScreen extends StatelessWidget {
  final bool isTechnical;
  final int index;

  const CommitteeDetailsScreen({
    super.key,
    required this.isTechnical,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            _buildPhotoAndTitle(),
            _buildDescription(),
            _buildBoardMembers(context),
            _buildViceBoardMembers(context),
            _buildBestMembers(context),
            GetInTouch(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoAndTitle() {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 200.h,
      width: 390.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(isTechnical
              ? technicalCommittees[index].iconPath
              : nonTechnicalCommittees[index].iconPath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
          isTechnical ? 'Technical Committee' : 'Non Technical Committee',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }

  Widget _buildDescription() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 356.w,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.primary, width: 5),
            right: BorderSide(color: AppColors.grey.withAlpha(20), width: 2),
            left: BorderSide(color: AppColors.grey.withAlpha(20), width: 2),
            bottom: BorderSide(color: AppColors.grey.withAlpha(20), width: 2),
          ),
        ),
        padding: EdgeInsets.all(20.r),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isTechnical
                  ? technicalCommittees[index].name
                  : nonTechnicalCommittees[index].name,
              textAlign: TextAlign.justify,
              style:
                  TextStyles.fontBold26White.copyWith(color: AppColors.primary),
            ),
            Text("About Committee", style: TextStyles.fontBold18Black),
            Text(
              isTechnical
                  ? technicalCommittees[index].description
                  : nonTechnicalCommittees[index].description,
              style: TextStyles.fontRegular16Gray,
            ),
            _buildActiveMembers(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveMembers() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(40),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 80.h,
      width: 170.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: <Widget>[
              Icon(Icons.people_alt, color: AppColors.primary),
              TweenAnimationBuilder<int>(
                tween: IntTween(
                    begin: 0,
                    end: (isTechnical
                        ? technicalCommittees[index].membersCount
                        : nonTechnicalCommittees[index].membersCount)),
                duration: Duration(seconds: 3),
                curve: Easing.standardDecelerate, // Adjust speed
                builder: (context, value, child) {
                  return Text(
                    "$value",
                    style: TextStyles.fontSemi20Black.copyWith(
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ],
          ),
          Text("Active Members", style: TextStyles.fontRegular16Gray),
        ],
      ),
    );
  }

  Widget _buildBoardMembers(BuildContext context) {
    String role = isTechnical
        ? technicalCommittees[index].name
        : nonTechnicalCommittees[index].name;
    final members =
        communityHBData.where((member) => member.role == (role)).toList();
    if (members.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "High Board",
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
              children: members.map((member) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: _boardCard(
                    context: context,
                    CommunityMemberModel: member,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViceBoardMembers(BuildContext context) {
    String role = isTechnical
        ? technicalCommittees[index].name
        : nonTechnicalCommittees[index].name;
    final members =
        communityViceData.where((member) => member.role == (role)).toList();
    if (members.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Vice Board",
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
              children: members.map((member) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: _boardCard(
                    context: context,
                    CommunityMemberModel: member,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestMembers(BuildContext context) {
    String role = isTechnical
        ? technicalCommittees[index].name
        : nonTechnicalCommittees[index].name;
    final members = communitybestMembersData
        .where((member) => member.role == (role))
        .toList();
    if (members.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Best members",
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
              children: members.map((member) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: _boardCard(
                    context: context,
                    CommunityMemberModel: member,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boardCard({
    required BuildContext context,
    required CommunityMemberModel CommunityMemberModel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => _buildMemberDialog(context, CommunityMemberModel),
            );
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary,
            child: CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(CommunityMemberModel.imagePath),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(CommunityMemberModel.name, style: TextStyles.fontSemi16Black),
        Text(CommunityMemberModel.role, style: TextStyles.fontRegular16Gray),
      ],
    );
  }

  Widget _buildMemberDialog(BuildContext context, CommunityMemberModel member) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(16),
      content: Column(
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
          ListTile(
            leading: Icon(Icons.email, color: AppColors.primary),
            title: Text(member.email!, style: TextStyles.fontRegular16Gray),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.linkedin,
                color: AppColors.primary, size: 20),
            title: GestureDetector(
              onTap: () async {
                final url =
                    Uri.parse(member.linkedIn ?? "https://www.linkedin.com/");
                await launchUrl(url);
              },
              child: Text("LinkedIn Profile",
                  style: TextStyle(color: Colors.blue)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.work, color: AppColors.primary),
            title: Text("Experience: +1 Years",
                style: TextStyles.fontRegular16Gray),
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
