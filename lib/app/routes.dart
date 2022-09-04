import 'package:flutter/material.dart';

import '../screens/index.dart';

class Routes {
  //TODO Define your routes name, init this routes in material App variable 'routes'
  Routes._();

  //static variables
  static const String initRoute = '/';
  static const String login = '/login';
  static const String map = '/map';
  static const String selectMapPoint = '/select_map_point';
  static const String addAnimal = '/addAnimal';
  static const String myAnimals = '/my_animals_screen';
  static const String profile = '/profile_screen';
  static const String editProfile = '/editProfile_screen';
  static const String codeVerification = '/codeVerification_screen.dart';
  static const String completeProfile = '/completeProfile_screen.dart';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(
            builder: (_) => const PhoneNumber(),
            settings: RouteSettings(name: initRoute));
      case login:
        return MaterialPageRoute(builder: (_) => const PhoneNumber());
      case codeVerification:
        //return MaterialPageRoute(builder: (_) => const CodeVerification());
        return MaterialPageRoute(builder: (_) => const RequestDeliveryScreen());
      case completeProfile:
        return MaterialPageRoute(builder: (_) => const CompleteProfile());
      case map:
        return MaterialPageRoute(builder: (_) => const RequestDeliveryScreen());
      case selectMapPoint:
        return MaterialPageRoute(builder: (_) => const SelectMapPointScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());
      case editProfile:
        Map<String, dynamic> user = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => EditProfile(
                  user: user,
                ));
      case addAnimal:
        //Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        if (settings.arguments == null) {
          return MaterialPageRoute(builder: (_) => AddAnimal());
        } else {
          Map animal = settings.arguments as Map<String, dynamic>;
          Map<String, dynamic> data = animal['data'];
          int index = animal['index'];
          return MaterialPageRoute(
              builder: (_) => AddAnimal(
                    data: data,
                    index: index,
                  ));
        }
      case myAnimals:
        return MaterialPageRoute(builder: (_) => const MyAnimals());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static final routes = <String, WidgetBuilder>{
    initRoute: (BuildContext context) => Login(),
  };
}
