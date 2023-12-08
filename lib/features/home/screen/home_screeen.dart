import 'package:contri/apis/auth_api.dart';
import 'package:contri/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User? userData;

    ref.watch(currentUserAccountProvider).whenData(
      (value) {
        userData = value;
      },
    );
    return Scaffold(
        body: Center(
      child: Text(userData.toString() ?? "No data"),
    ));
  }
}
