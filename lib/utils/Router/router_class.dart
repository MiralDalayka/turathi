import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/screens/SignIn/Signup.dart';
import 'package:turathi/view/screens/SignIn/signin.dart';
import 'package:turathi/view/screens/add_data_screens/edit_place_page.dart';
import 'package:turathi/view/screens/admin_screens/events_admin.dart';
import 'package:turathi/view/screens/admin_screens/places_admin.dart';
import 'package:turathi/view/screens/profile_screens/screens/change_pass.dart';
import 'package:turathi/view/screens/profile_screens/screens/notification/notification_page.dart';
import 'package:turathi/view/screens/placesdetails_screens/comments_place_screen.dart';
import 'package:turathi/view/screens/profile_screens/screens/aboutus_page.dart';
import 'package:turathi/view/screens/profile_screens/screens/change_info.dart';
import 'package:turathi/view/screens/profile_screens/screens/delete_user.dart';
import 'package:turathi/view/screens/profile_screens/screens/personalDetils_screen.dart';

import '../../core/models/event_model.dart';
import '../../core/models/question_model.dart';
import '../../view/screens/add_data_screens/add_event_page.dart';
import '../../view/screens/add_data_screens/add_place_page.dart';
import '../../view/screens/admin_screens/admin_home_page.dart';
import '../../view/screens/admin_screens/admin_signin_screen.dart';
import '../../view/screens/admin_screens/edit_place_admin.dart';
import '../../view/screens/admin_screens/place_reports.dart';
import '../../view/screens/admin_screens/reports_screen.dart';
import '../../view/screens/admin_screens/requests_screen.dart';
import '../../view/screens/admin_screens/widgets/view_pdf.dart';
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

      case eventsAdminRoute:
        {
          return _route(eventsAdmin());
        }

      case placesAdminRoute:
        {
          return _route(placesAdmin());
        }

      case aboutUsScreen:
        {
          return _route(AboutUsScreen());
        }
      case changePass:
        {
          return _route(ChangePass());
        }
      case signIn:
        {
          return _route(LogIn());
        }

      case deleteuserpage:
        {
          return _route(DeleteUser());
        }

      case personalDetilsScreen:
        {
          return _route(PersdonalDetilsScreen());
        }

      // NotificationPage

      case notificationPage:
        {
          return _route(NotificationPage());
        }

      case changeInfo:
        {
          return _route(ChangeInfo());
        }

      case signUp:
        {
          return _route(SingUp());
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

          return _route(const EventsScreen());
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
      case editPlaceRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(EditPlace(
            placeModel: arg,
          ));
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
            placeId: arg,
          ));
        }
      //////////////////////////////////admin
      case signInAdminRoute:
        {
          return _route(const AdminSignIn());
        }
      case homeAdminRoute:
        {
          return _route(const AdminHomePage());
        }
      case requestsAdminRoute:
        {
          return _route(const RequestScreen());
        }
      case allReportsAdminRoute:
        {
          return _route(const ReportsScreen());
        }
      case placeReportsAdminRoute:
        {
          final arg = settings.arguments as List<ReportModel>;

          return _route(PlaceReportsScreen(
            reportList: arg,
          ));
        }
      case requestPDFViewAdminRoute:
        {
          final arg = settings.arguments as String;

          return _route(PdfViewPage(
            path: arg,
          ));
        }
      case editPlacesAdminRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(EditPlaceAdmin(
          placeModel: arg,
          ));
        }
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
        ),
      ),
    );
  }
}
