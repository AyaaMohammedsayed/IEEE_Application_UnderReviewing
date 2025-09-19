import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';

class EventExpandedContent extends StatelessWidget {
  final List<EventModel> eventList;
  final int index;

  const EventExpandedContent({
    super.key,
    required this.eventList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final event = eventList[index];

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مقال عن الحدث
          Text(
            "About the Event",
            style: TextStyles.fontBold18Black,
          ),
          SizedBox(height: 6.h),
          Text(
            event.description,
            style: TextStyles.fontRegular16Gray,
            textAlign: TextAlign.justify,
          ),

          SizedBox(height: 12.h),

          // الإنجازات
          if (event.achievements.isNotEmpty) ...[
            Text("Achievements", style: TextStyles.fontBold18Black),
            SizedBox(height: 6.h),
            Text(
              event.achievements,
              style: TextStyles.fontRegular16Gray,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12.h),
          ],

          // عدد الحاضرين
          if (event.attendeesCount != null) ...[
            Text("Attendees", style: TextStyles.fontBold18Black),
            SizedBox(height: 6.h),
            Text(
              "${event.attendeesCount} people attended the event.",
              style: TextStyles.fontRegular16Gray,
            ),
            SizedBox(height: 12.h),
          ],

          // أهم الحاضرين وصورهم
 ],
      ),
    );
  }
}
