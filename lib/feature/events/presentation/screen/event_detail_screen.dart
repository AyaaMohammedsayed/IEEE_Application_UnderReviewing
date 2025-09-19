import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/core/widgets/get_in_touch.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';

class EventScreenDetails extends StatelessWidget {
  final EventModel event;

  const EventScreenDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          event.title,
          style: TextStyles.fontBold26White.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                event.imagePath,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 24.h),

            // Event Gallery
            if (event.eventImages.isNotEmpty) ...[
              SectionTitle("Event Gallery"),
              SizedBox(height: 12.h),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.eventImages.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      event.eventImages[index],
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Divider(height: 32.h, color: Colors.grey.shade300),
            ],

            // Achievements
            SectionTitle("Achievements"),
            SizedBox(height: 8.h),
            Text(
              event.achievements,
              style: TextStyles.fontRegular16Gray.copyWith(height: 1.6),
              textAlign: TextAlign.justify,
            ),
            Divider(height: 32.h, color: Colors.grey.shade300),

            // Attendees
            SectionTitle("Attendees"),
            SizedBox(height: 8.h),
            Text(
              "${event.attendeesCount} attendees",
              style: TextStyles.fontRegular16Gray,
            ),
            Divider(height: 32.h, color: Colors.grey.shade300),

            // About
            SectionTitle("About"),
            SizedBox(height: 8.h),
            Text(
              event.description,
              style: TextStyles.fontRegular16Gray.copyWith(height: 1.6),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 36.h),
            const GetInTouch(),
          ],
        ),
      ),
    );
  }

  // Reusable section title widget
  Widget SectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.fontBold18Black.copyWith(
        color: AppColors.primary,
        fontSize: 18.sp,
      ),
    );
  }
}
