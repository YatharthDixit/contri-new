import 'package:contri/apis/expense_api.dart';
import 'package:contri/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ExpenseControllerProvider =
    StateNotifierProvider<ExpenseController, bool>((ref) {
  return ExpenseController(expenseAPI: ref.watch(expenseAPIProvider));
});

class ExpenseController extends StateNotifier<bool> {
  final ExpenseAPI _expenseAPI;

  ExpenseController({required ExpenseAPI expenseAPI})
      : _expenseAPI = expenseAPI,
        super(false);

  Future<List<Expense>> getExpenses() async {
    List<Expense> expenses = [];
    expenses = await _expenseAPI.getExpenses();
    return expenses;
  }

  Future<Map<String, dynamic>> getBalance() async {
    Map<String, dynamic> balance = {
      'incomingAmount': 0,
      'outgoingAmount': 0,
    };
    balance = await _expenseAPI.getBalance();
    return balance;
  }
}
