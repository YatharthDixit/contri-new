import 'package:contri/models/expense.dart';
import 'package:contri/theme/pallete.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class ExpenseStatusCard extends StatelessWidget {
  final Expense? expense;
  // final UserModel user;
  const ExpenseStatusCard({super.key, this.expense
      //  required this.user
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.22,
      width: size.width * 0.95,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Pallete.blueLightColor,
                Pallete.pinkLightColor,
                Pallete.orangeLightColor
              ]),
          borderRadius: BorderRadius.circular(45)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expense!.description,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '₹${expense!.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 14,
                              color: Pallete.whiteColor.withAlpha(400),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          expense!.date.format('j M y'),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 14,
                              color: Pallete.whiteColor.withAlpha(400),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          expense!.type,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
