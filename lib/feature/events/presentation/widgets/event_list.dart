import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';
import 'package:ieee_app/feature/events/presentation/widgets/event_card.dart';


class EventList extends StatelessWidget {
  final List<EventModel> eventList;
  final List<bool> expandedStates;
  final Function(int) onItemTapped;

  const EventList({
    super.key,
    required this.eventList,
    required this.expandedStates,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: eventList.length,
      itemBuilder: (context, index) => EventCard(
        key: ValueKey('event-$index'),
        index: index,
        eventList: eventList,
        isExpanded: expandedStates[index],
        onTap: () => onItemTapped(index),
      ),
    );
  }
}
