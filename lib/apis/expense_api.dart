import 'dart:convert';

import 'package:contri/constants/constants.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/features/expense/controller/expense_controller.dart';
import 'package:contri/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final expenseAPIProvider = Provider((ref) {
  return ExpenseAPI();
});

final expensesProvider = FutureProvider((ref) async {
  final expenseController = ref.watch(ExpenseControllerProvider.notifier);
  return expenseController.getExpenses();
});

final balanceProvider = FutureProvider((ref) async {
  final expenseController = ref.watch(ExpenseControllerProvider.notifier);
  return expenseController.getBalance();
});

abstract class IExpenseAPI {
  Future<Map<String, dynamic>> getBalance();
  Future<List<Expense>> getExpenses();
  // Future<Expense> addExpense(BuildContext context, Expense expense);
  // Future<Expense> updateExpense(Expense expense);
  // Future<Expense> deleteExpense(Expense expense);
}

class ExpenseAPI implements IExpenseAPI {
  // @override
  // Future<Expense> addExpense(BuildContext context, Expense expense, ) {}

  @override
  Future<List<Expense>> getExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('x-auth-token');
    if (token == null) {
      print("No token Found");
      return [];
    }
    List<Expense> expenses = [];
    // print("calling expense get");
    // try {
    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/expense/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });

    final data = jsonDecode(response.body);
    // print(data.length);
    for (int i = 0; i < data.length; i++) {
      // print("$i + ::::::::: + ${data[i]}");
      // print(data[i].runtimeType);
      expenses.add(Expense.fromMap(data[i]));
    }
    // } catch (e) {
    //   print(e);
    // }
    return expenses;
    // print(data);
  }

  @override
  Future<Map<String, dynamic>> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('x-auth-token');
    if (token == null) {
      print("No token Found");
      return {};
    }
    Map<String, dynamic> result = {
      'incomingAmount': 0,
      'outgoingAmount': 0,
    };
    print("calling expense get");
    try {
      http.Response response = await http.get(
          Uri.parse('${Constants.BASE_URL}/api/balance/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
      print(response.body);
      result = jsonDecode(response.body)["summary"];
      print("result");
      print(result);
    } catch (e) {
      print(e);
    }
    return result;
  }
}
