import 'package:contri/features/auth/view/enter_name.dart';
import 'package:contri/features/auth/view/login_view.dart';
import 'package:contri/features/auth/view/select_image.dart';
import 'package:contri/features/expense/screens/create_expense.dart';
import 'package:contri/features/expense/screens/expense_details.dart';
import 'package:contri/features/friends/screens/friend_screen.dart';
import 'package:contri/features/friends/screens/select_friends.dart';
import 'package:contri/features/home/screen/home_screeen.dart';
import 'package:contri/models/expense.dart';
import 'package:contri/models/user.dart';
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
    case SelectContactsGroup.routeName:
      var data = routeSetting.arguments as Map<String, dynamic>;
      return ModalBottomSheetRoute(
        isScrollControlled: true,
        builder: (_) => SelectContactsGroup(selectedContactAndIndex: data),
        settings: routeSetting,
      );
    case AddExpenseScreen.routeName:
      var data = routeSetting.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => AddExpenseScreen(selectedContactAndIndex: data),
        settings: routeSetting,
      );
    case EnterNameScreen.routeName:
      var phoneNumber = routeSetting.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EnterNameScreen(phoneNumber: phoneNumber),
        settings: routeSetting,
      );
    case ExpenseDetailsScreen.routeName:
      var expense = routeSetting.arguments as Expense;
      return MaterialPageRoute(
        builder: (_) => ExpenseDetailsScreen(expense: expense),
        settings: routeSetting,
      );
    case FriendsView.routeName:
      var friend = routeSetting.arguments as User;
      return MaterialPageRoute(
        builder: (_) => FriendsView(friend: friend),
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
