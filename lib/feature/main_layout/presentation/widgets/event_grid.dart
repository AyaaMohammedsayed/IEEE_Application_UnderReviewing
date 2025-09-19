import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/feature/committes/data/models/commitee_data.dart';
import 'package:ieee_app/feature/committes/data/models/committee.dart';
import 'package:ieee_app/feature/events/data/event_data.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';
import '../../../../core/constants/app_colors.dart';

class EventSection extends StatelessWidget {
  final List<EventModel> events;

  const EventSection({super.key, required this.events});

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
              Icon(Icons.event, color: Colors.white, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                "Discover Our Events",
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
        CommitteeGridView(events: events),
      ],
    );
  }
}

class CommitteeGridView extends StatelessWidget {
  final List<EventModel> events;

  const CommitteeGridView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: events.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return CommitteeCard(events: dataEvents[index]);
        },
      ),
    );
  }
}

class CommitteeCard extends StatelessWidget {
  final EventModel events;

  const CommitteeCard({super.key, required this.events});

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.eventScreenDetails,
          arguments: events,
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 260.w,
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
                events.imagePath,
                height: 110.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // اسم اللجنة
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Text(
                events.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
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
