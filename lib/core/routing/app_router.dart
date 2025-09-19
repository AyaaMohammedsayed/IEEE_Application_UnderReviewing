import 'package:flutter/material.dart';

import 'package:ieee_app/feature/Auth/Presenetation/register_screen.dart';
import 'package:ieee_app/feature/committes/presentation/screens/committee_details_screen.dart';
import 'package:ieee_app/feature/committes/presentation/screens/committees_screen.dart';
import 'package:ieee_app/feature/events/data/event_modal.dart';
import 'package:ieee_app/feature/events/presentation/screen/event_detail_screen.dart';
import 'package:ieee_app/feature/events/presentation/screen/event_screen.dart';
import 'package:ieee_app/feature/main_layout/presentation/screens/about.dart';
import 'package:ieee_app/feature/main_layout/presentation/screens/home_screen.dart';
import 'package:ieee_app/feature/main_layout/presentation/screens/join.dart';
import 'package:ieee_app/feature/main_layout/presentation/widgets/custom_sponsor_widget.dart';
import 'package:ieee_app/feature/onboarding/onboarding_screen.dart';
import 'package:ieee_app/feature/profile/presentation/screens/profile_screen.dart';


import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // this arguments is to be passed in any screen like this ( argument as ClassName )
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case Routes.onboardinScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.committeesScreen:
        return MaterialPageRoute(builder: (_) => CommitteesScreen());
      case Routes.committeeDetailsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final args = arguments as Map<String, dynamic>;
            return CommitteeDetailsScreen(
              isTechnical: args['isTechnical'],
              index: args['index'],
            );
          },
        );
      case Routes.eventScreen:
        return MaterialPageRoute(builder: (_) => EventsScreen());
case Routes.eventScreenDetails:
  final event = settings.arguments as EventModel;
  return MaterialPageRoute(
    builder: (_) => EventScreenDetails(event: event),
  );


      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());
      case Routes.aboutUsScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case Routes.joinUsScreen:
        return MaterialPageRoute(builder: (_) => const JoinUsScreen());

      default:
        return null;
    }
  }
}
