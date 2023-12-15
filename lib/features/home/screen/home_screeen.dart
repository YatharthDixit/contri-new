import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:contri/apis/auth_api.dart';
import 'package:contri/apis/expense_api.dart';
import 'package:contri/common/loader.dart';
import 'package:contri/features/expense/widget/expense_row.dart';
import 'package:contri/features/home/widget/status_card.dart';
import 'package:contri/features/home/widget/title_row.dart';
import 'package:contri/features/home/widget/top_bar.dart';
import 'package:contri/models/expense.dart';
import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/select-profile-photo-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _bottomNavIndex = 0;

  @override
  List<String> phoneNumbers = ["+918960685939", "+917417048840"];

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    User? userData;

    ref.watch(currentUserAccountProvider).whenData(
      (value) {
        userData = value;
      },
    );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Pallete.blueLightColor,
                Pallete.pinkLightColor,
                Pallete.orangeLightColor
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        // onPressed: () {
        //   List<Contact> c = [];
        //   Navigator.pushNamed(context, AddExpenseScreen.routeName,
        //       arguments: {
        //         "contact": [],
        //         "index": [],
        //         "user": widget.user,
        //       });
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : const Text(
                    "Users",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          ref.watch(expensesProvider).when(data: (data) {
            return Expanded(
              child: expenseListWidget(data: data),
            );
          }, error: (error, stacktrace) {
            return Text("Some error Occured");
          }, loading: () {
            return Loader();
          }),
        ]),
      )),
    );
  }
}

class expenseListWidget extends StatelessWidget {
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
  expenseListWidget({
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
          child: ExpenseRowWidget(
              icon: icon(data[newIndex].type),
              description: data[newIndex].description,
              amount: expense.totalAmount,
              date: expense.date.format('j M y'),
              iconColor: iconColor(expense.type)),
        );
      },
    );
  }
}
