import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/core/routing/routes.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';

import 'package:ieee_app/feature/events/presentation/widgets/action_button.dart';
import 'package:ieee_app/feature/events/presentation/widgets/collapsed_content.dart';

import 'package:ieee_app/feature/events/presentation/widgets/expanded_content.dart';
import 'package:ieee_app/feature/events/presentation/widgets/header_section.dart';

class EventCard extends StatelessWidget {
  final int index;
  final List<EventModel> eventList;
  final bool isExpanded;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.index,
    required this.eventList,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final EventModel event = eventList[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        enableFeedback: false,
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderSection(event: event),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: EventCollapsedContent(event: event),
                secondChild: Column(
                  children: [
                    EventExpandedContent(eventList: eventList,index: index,),
                    EventActionButton(
                      onTap: () {
                   context.pushNamed(
  Routes.eventScreenDetails,
  arguments: eventList[index],
);

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
