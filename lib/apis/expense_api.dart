import 'dart:convert';

import 'package:contri/constants/constants.dart';
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

final expenseProvider = FutureProvider.family((ref, String expenseId) async {
  final expenseController = ref.watch(ExpenseControllerProvider.notifier);
  return expenseController.getExpense(expenseId);
});

final balanceProvider = FutureProvider((ref) async {
  final expenseController = ref.watch(ExpenseControllerProvider.notifier);
  return expenseController.getBalance();
});

abstract class IExpenseAPI {
  Future<Map<String, dynamic>> getBalance();
  Future<List<Expense>> getExpenses();
  Future<Expense?> getExpense(String expenseId);

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

      result = jsonDecode(response.body);
      print("result");
      print(result);
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Future<Expense?> getExpense(String expenseId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token != null) {
        debugPrint(token);
      }
      if (token == null) {
        pref.setString('x-auth-token', '');
        return null;
      }

      http.Response expenseRes = await http.post(
          Uri.parse('${Constants.BASE_URL}/api/expense/get'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body: jsonEncode({
            'expenseId': expenseId,
          }));
      print(expenseRes.body);

      final expense = Expense.fromJson(expenseRes.body);

      return expense;

      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.setUser(userRes.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
