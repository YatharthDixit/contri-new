import 'dart:convert';

import 'package:contri/constants/constants.dart';
import 'package:contri/features/friends/friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final friendExpensesProvider =
    FutureProvider.family((ref, String friendPhone) async {
  final friendController = ref.watch(friendControllerProvider.notifier);
  return friendController.getFriendExpenses(friendPhone);
});

final friendBalanceProvider =
    FutureProvider.family((ref, String friendPhone) async {
  return ref.watch(friendControllerProvider.notifier).getBalance(friendPhone);
});
final friendsProvider = FutureProvider((ref) async {
  final friendController = ref.watch(friendControllerProvider.notifier);
  return friendController.getFriends();
});

final friendAPIProvider = Provider((ref) {
  return FriendAPI();
});

abstract class IFriendAPI {
  Future<List<String>> getFriends();
  Future<double?> getBalance(String friendPhone);
  Future<List<String>> getFriendExpenses(String friendPhone);
}

class FriendAPI implements IFriendAPI {
  @override
  Future<double> getBalance(String friendPhone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('x-auth-token');
    if (token == null) {
      print("No token Found");
      return 0.0;
    }

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/balance/friend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
        body: jsonEncode({
          'friendPhone': friendPhone,
        }));

    final data = jsonDecode(response.body);

    return data == null ? 0.0 : data["balance"] + 0.0;
  }

  @override
  Future<List<String>> getFriends() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> friends = [];
    String? token = pref.getString('x-auth-token');
    if (token == null) {
      debugPrint("No token Found");

      return friends;
    }

    // print("calling expense get");
    // try {
    http.Response response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/friends'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      },
    );

    final data = jsonDecode(response.body);
    print(data['friends']);

    if (data == null) return friends;

    friends = data['friends'].cast<String>();
    return friends;
    // TODO: implement getFriends
  }

  @override
  Future<List<String>> getFriendExpenses(String friendPhone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> expenses = [];
    String? token = pref.getString('x-auth-token');
    if (token == null) {
      debugPrint("No token Found");

      return expenses;
    }
    try {
      http.Response response = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/friend/expenses'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
        body: jsonEncode({
          'friendPhone': friendPhone,
        }),
      );

      final data = jsonDecode(response.body);

      if (data == null) return expenses;

      expenses = data['expenses'].cast<String>();
    } catch (e) {
      print(e);
    }
    return expenses;
  }
}
