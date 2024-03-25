import 'package:flutter/material.dart';

import '../../core/models/question_model.dart';
import '../../view/screens/community_screens/question_view.dart';
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



      case questionRoute:
        {
          final arg = settings.arguments as QuestionModel;
          return _route(QuestionView(question: arg,));
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