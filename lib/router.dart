import 'package:contri/features/auth/view/enter_name.dart';
import 'package:contri/features/auth/view/login_view.dart';
import 'package:contri/features/auth/view/select_image.dart';
import 'package:contri/features/home/screen/home_screeen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: routeSetting,
      );
    case LoginView.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
        settings: routeSetting,
      );
    case EnterNameScreen.routeName:
      var phoneNumber = routeSetting.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EnterNameScreen(phoneNumber: phoneNumber),
        settings: routeSetting,
      );
    case SelectProfilePhotoScreen.routeName:
      var data = routeSetting.arguments as Map<String, String>;
      return MaterialPageRoute(
        builder: (_) => SelectProfilePhotoScreen(data: data),
        settings: routeSetting,
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
                'No route defined for ${routeSetting.name}, Please take a screenshot and let us know.'),
          ),
        ),
        settings: routeSetting,
      );
  }
}
