import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/view/screens/placesdetails_screens/comments_place.dart';

import '../../core/models/event_model.dart';
import '../../core/models/question_model.dart';
import '../../view/screens/add_data_screens/add_event_page.dart';
import '../../view/screens/add_data_screens/add_place_page.dart';
import '../../view/screens/community_screens/question_view.dart';
import '../../view/screens/events_screens/event_details.dart';
import '../../view/screens/events_screens/view_all_events.dart';
import '../../view/screens/placesdetails_screens/details_place.dart';
import '../../view/screens/placesdetails_screens/report_screen.dart';
import '../../view/screens/profile_screens/screens/added_places.dart';
import '../../view/screens/profile_screens/screens/request_to_be_expert.dart';
import '../../view/screens/splach_screen/splach_screen.dart';
import '../../view/widgets/custom_bottom_nav_bar.dart';
import 'const_router_names.dart';

class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        {
          return _route(SplashScreen());
        }

      case bottomNavRoute:
        {
          return _route(CustomeBottomNavBar());
        }

      case placeDetailsRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(DetailsScreen(
            placeModel: arg,
          ));
        }

      case questionRoute:
        {
          final arg = settings.arguments as QuestionModel;
          return _route(QuestionView(
            question: arg,
          ));
        }

      case addedPlacesRoute:
        {
          return _route(AddedPlaces());
        }

      case eventsRoute:
        {
          final arg = settings.arguments as List<EventModel>;

          return _route(EventsScreen(eventsList: arg));
        }
      case eventDetailsRoute:
        {
          final arg = settings.arguments as EventModel;

          return _route(EventDetailsScreen(eventModel: arg));
        }
      case addNewPlaceRoute:
        {
          return _route(const AddNewPlace());
        }
      case addNewEventRoute:
        {
          return _route(const AddNewEvent());
        }
      case requestToBeExpertRoute:
        {
          return _route(const RequestToBeExpert());
        }
      case addReportRoute:
        {
          final arg = settings.arguments as String;
          return _route(ReportPlace(
            placeID: arg,
          ));
        }
        case commentsPlaceRoute:
        {
          return _route(const CommentsPlace());
        }
      // case ex:
      //   {
      //     final arg = settings.arguments as modelName;
      //     return _route(PageClass(
      //       model: arg,
      //     ));
      //   }

      default:
        {
          final arg = settings.name as String;
          return _route(UndefineRoute(routeName: arg));
        }
    }
  }

  static MaterialPageRoute _route(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}

class UndefineRoute extends StatelessWidget {
  const UndefineRoute({Key? key, required this.routeName}) : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This $routeName is Undefine Route',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
