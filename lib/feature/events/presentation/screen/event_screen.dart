import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ieee_app/core/constants/app_colors.dart';
import 'package:ieee_app/core/constants/app_vectors.dart';
import 'package:ieee_app/core/constants/text_styles.dart';
import 'package:ieee_app/core/helpers/extentions.dart';
import 'package:ieee_app/feature/events/data/event_data.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';

import 'package:ieee_app/feature/events/presentation/widgets/event_list.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<EventModel> allEvents = dataEvents;

  late final List<bool> expandedStates;

  @override
  void initState() {
    super.initState();
    expandedStates = List.generate(allEvents.length, (_) => false);
  }

  void _toggleExpansion(int index) {
    setState(() {
      expandedStates[index] = !expandedStates[index];
      for (int i = 0; i < expandedStates.length; i++) {
        if (i != index) expandedStates[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: EventList(
      
        eventList: allEvents,
        expandedStates: expandedStates,
    onItemTapped: _toggleExpansion,

      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(AppVectors.arrowBack),
        onPressed: () => context.pop(),
      ),
      centerTitle: true,
      title: Text(
        'Events',
        style: TextStyles.fontSemi20Black.copyWith(
          color: AppColors.primary,
          letterSpacing: 1.sp,
        ),
      ),
    );
  }
}
