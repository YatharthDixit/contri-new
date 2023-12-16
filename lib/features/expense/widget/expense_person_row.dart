import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';

class ExpensePerson extends StatelessWidget {
  final User user;
  final double amount;
  const ExpensePerson({super.key, required this.user, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(user.photoURL),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Text(
          amount.toStringAsFixed(2),
          style: TextStyle(
              fontSize: 16,
              color: Pallete.greyColor,
              fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}
