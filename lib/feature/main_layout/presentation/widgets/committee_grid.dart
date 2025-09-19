import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/feature/committes/data/models/commitee_data.dart';
import 'package:ieee_app/feature/committes/data/models/committee.dart';
import '../../../../core/constants/app_colors.dart';

class CommitteeSection extends StatelessWidget {
  final List<CommitteeModel> committees;

  const CommitteeSection({super.key, required this.committees});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان جذاب مع أيقونة
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(Icons.groups, color: Colors.white, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                "Discover Our Committees",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // عرض الكروت
        CommitteeGridView(committees: committees),
      ],
    );
  }
}

class CommitteeGridView extends StatelessWidget {
  final List<CommitteeModel> committees;

  const CommitteeGridView({super.key, required this.committees});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: committees.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return CommitteeCard(committee: committees[index]);
        },
      ),
    );
  }
}

class CommitteeCard extends StatelessWidget {
  final CommitteeModel committee;

  const CommitteeCard({super.key, required this.committee});

  @override
  Widget build(BuildContext context) {
    final isTechnical = technicalCommittees.contains(committee);
    final committeeIndex = isTechnical
        ? technicalCommittees.indexOf(committee)
        : nonTechnicalCommittees.indexOf(committee);

    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.committeeDetailsScreen,
          arguments: {
            "isTechnical": isTechnical,
            "index": committeeIndex,
          },
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 150.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة اللجنة
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.asset(
                committee.iconPath,
                height: 110.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // اسم اللجنة
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Text(
                committee.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
