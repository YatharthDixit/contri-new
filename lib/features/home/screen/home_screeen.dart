import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:contri/apis/auth_api.dart';
import 'package:contri/apis/expense_api.dart';
import 'package:contri/apis/friend_api.dart';
import 'package:contri/common/loader.dart';
import 'package:contri/features/expense/screens/create_expense.dart';
import 'package:contri/features/expense/screens/expense_details.dart';
import 'package:contri/features/expense/widget/expense_row.dart';
import 'package:contri/features/home/widget/friends_row.dart';
import 'package:contri/features/home/widget/status_card.dart';
import 'package:contri/features/home/widget/top_bar.dart';
import 'package:contri/models/expense.dart';
import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // User? userData;

    return ref.watch(currentUserAccountProvider).when(
      data: (userData) {
        return Scaffold(
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [Icons.home_rounded, Icons.people_rounded],
            activeColor: Pallete.pinkLightColor,
            notchMargin: 5,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            onTap: (index) => setState(() => _bottomNavIndex = index),
            //other params
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
              elevation: 0,
              // onPressed: () {
              //   Navigator.pushNamed(
              //     context,
              //     AddExpenseScreen.routeName,
              //     arguments: <String, dynamic>{},
              //   );

              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Pallete.blueLightColor,
                      Pallete.pinkLightColor,
                      Pallete.orangeLightColor
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              onPressed: () {
                List<Contact> c = [];
                Navigator.pushNamed(context, AddExpenseScreen.routeName,
                    arguments: {
                      "contact": [],
                      "index": [],
                      "user": userData,
                    });
              }),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeTopBar(user: userData!),
                  const SizedBox(
                    height: 20,
                  ),
                  const StatusCard(),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                    width: size.width * 0.95,
                    child: _bottomNavIndex == 0
                        ? const Text(
                            "Recent Expenses",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "Users",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _bottomNavIndex == 0
                      ? ref.watch(expensesProvider).when(data: (data) {
                          return Expanded(
                            child: ExpenseListWidget(data: data),
                          );
                        }, error: (error, stacktrace) {
                          return const Text("Some error Occured");
                        }, loading: () {
                          return const Loader();
                        })
                      : ref.watch(friendsProvider).when(data: (data) {
                          return Expanded(
                            child: UserRowWidget(data: data, user: userData!),
                          );
                        }, error: (error, stacktrace) {
                          return const Text("Some error Occured");
                        }, loading: () {
                          return const Loader();
                        }),
                ]),
          )),
        );
      },
      error: (error, stacktrace) {
        return const Loader();
      },
      loading: () {
        return const Loader();
      },
    );
  }
}

class ExpenseListWidget extends StatelessWidget {
  Color iconColor(String i) {
    switch (i) {
      case 'Groceries':
        return Colors.cyan;
      case 'Home':
        return Colors.pink;
      case 'Travel':
        return Colors.blue;
      case 'Foods & Drinks':
        return Colors.orange;
      case 'Payments':
        return Colors.green;
      case 'Personal':
        return Colors.blue;
      case 'Shopping':
        return Colors.purple;
      case 'Others':
        return Colors.lime;
      default:
        return Colors.green;
    }
  }

  IconData icon(String i) {
    switch (i) {
      case 'Groceries':
        return Icons.breakfast_dining;
      case 'Home':
        return Icons.home;
      case 'Travel':
        return Icons.emoji_transportation;
      case 'Foods & Drinks':
        return Icons.restaurant;
      case 'Payments':
        return Icons.payment;
      case 'Personal':
        return Icons.person;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Others':
        return Icons.miscellaneous_services;
      default:
        return Icons.miscellaneous_services;
    }
  }

  final List<Expense> data;
  const ExpenseListWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        int newIndex = data.length - index - 1;
        Expense expense = data[newIndex];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // print("clicked");
              Navigator.pushNamed(context, ExpenseDetailsScreen.routeName,
                  arguments: expense);
            },
            child: ExpenseRowWidget(
                icon: icon(data[newIndex].type),
                description: data[newIndex].description,
                amount: expense.totalAmount,
                date: expense.date.format('j M y'),
                iconColor: iconColor(expense.type)),
          ),
        );
      },
    );
  }
}

class UserRowWidget extends ConsumerWidget {
  final List<String> data;
  final User user;
  // final data;
  const UserRowWidget({super.key, required this.user, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        int newIndex = data.length - index - 1;
        if (data[newIndex] == user.phoneNumber) {
          return Container();
        }
        // if(data[newIndex] == )
        String friendPhone = data[newIndex];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            child: FriendRowWidget(
              friendPhone: friendPhone,
            ),
          ),
        );
      },
    );
  }
}
