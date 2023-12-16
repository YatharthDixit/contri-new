import 'dart:convert';

import 'package:collection/collection.dart';

class Expense {
  final double totalAmount;
  final String id;
  final String description;
  final String type;
  final Map<String, double> userPaid;
  final Map<String, double> userSpent;
  final String groupId;
  final bool isGroupExpense;
  final DateTime date;
  final String userCreated;
  final bool isSettlement;
  Expense({
    required this.totalAmount,
    required this.id,
    required this.description,
    required this.type,
    required this.userPaid,
    required this.userSpent,
    required this.groupId,
    required this.isGroupExpense,
    required this.date,
    required this.userCreated,
    required this.isSettlement,
  });

  Expense copyWith({
    double? totalAmount,
    String? id,
    String? description,
    String? type,
    Map<String, double>? userPaid,
    Map<String, double>? userSpent,
    String? groupId,
    bool? isGroupExpense,
    DateTime? date,
    String? userCreated,
    bool? isSettlement,
  }) {
    return Expense(
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      userPaid: userPaid ?? this.userPaid,
      userSpent: userSpent ?? this.userSpent,
      groupId: groupId ?? this.groupId,
      isGroupExpense: isGroupExpense ?? this.isGroupExpense,
      date: date ?? this.date,
      userCreated: userCreated ?? this.userCreated,
      isSettlement: isSettlement ?? this.isSettlement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'id': id,
      'description': description,
      'type': type,
      'userPaid': userPaid,
      'userSpent': userSpent,
      'groupId': groupId,
      'isGroupExpense': isGroupExpense,
      'date': date.millisecondsSinceEpoch,
      'userCreated': userCreated,
      'isSettlement': isSettlement,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      totalAmount: 0.0 + map['totalAmount'],
      id: map['_id'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      userPaid: Map<String, dynamic>.from(map['userSpent'])
          .map((key, value) => MapEntry(key, (value + 0.0))),
      userSpent: Map<String, dynamic>.from(map['userSpent'])
          .map((key, value) => MapEntry(key, (value + 0.0))),
      groupId: map['groupId'] ?? '',
      isGroupExpense: map['isGroupExpense'] ?? false,
      date: DateTime.parse(map['date']),
      userCreated: map['userCreated'] ?? '',
      isSettlement: map['isSettlement'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(totalAmount: $totalAmount, id: $id, description: $description, type: $type, userPaid: $userPaid, userSpent: $userSpent, groupId: $groupId, isGroupExpense: $isGroupExpense, date: $date, userCreated: $userCreated, isSettlement: $isSettlement)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is Expense &&
        other.totalAmount == totalAmount &&
        other.id == id &&
        other.description == description &&
        other.type == type &&
        mapEquals(other.userPaid, userPaid) &&
        mapEquals(other.userSpent, userSpent) &&
        other.groupId == groupId &&
        other.isGroupExpense == isGroupExpense &&
        other.date == date &&
        other.userCreated == userCreated &&
        other.isSettlement == isSettlement;
  }

  @override
  int get hashCode {
    return totalAmount.hashCode ^
        id.hashCode ^
        description.hashCode ^
        type.hashCode ^
        userPaid.hashCode ^
        userSpent.hashCode ^
        groupId.hashCode ^
        isGroupExpense.hashCode ^
        date.hashCode ^
        userCreated.hashCode ^
        isSettlement.hashCode;
  }
}


// userPaid: Map<String, int>.from(map['userSpent'])
//           .map((key, value) => MapEntry(key, double.parse(value.toString()))),
//       userSpent: Map<String, int>.from(map['userSpent'])
//           .map((key, value) => MapEntry(key, double.parse(value.toString()))),