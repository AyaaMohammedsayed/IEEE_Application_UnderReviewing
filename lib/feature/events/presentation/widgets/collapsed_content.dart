import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';

class EventCollapsedContent extends StatelessWidget {
  final EventModel event;

  const EventCollapsedContent({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        event.description,
        textAlign: TextAlign.justify,
        style: TextStyles.fontRegular16Gray,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
