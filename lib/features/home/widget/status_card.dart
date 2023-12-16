import 'package:contri/apis/expense_api.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:contri/utils/constants.dart';

class StatusCard extends ConsumerWidget {
  const StatusCard({
    Key? key,
    // required this.inc,
    // required this.out,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double incomingAmount = 0;
    double outgoingAmount = 0;
    ref.watch(balanceProvider).whenData((data) {
      incomingAmount = data['incomingAmount']! + 0.0;
      outgoingAmount = data['outgoingAmount']! + 0.0;
    });
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      // width: size.width * 0.95,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Pallete.blueLightColor,
                Pallete.pinkLightColor,
                Pallete.orangeLightColor,
              ]),
          borderRadius: BorderRadius.circular(45)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 25, left: 20, right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Balance",
                style: TextStyle(
                    color: Pallete.greyBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${(incomingAmount - outgoingAmount).toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Pallete.whiteColor.withAlpha(160),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            size: 30,
                            color: Colors.green[400],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recieve",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Pallete.whiteColor.withAlpha(400),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "₹${incomingAmount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Pallete.whiteColor.withAlpha(160),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            size: 30,
                            color: Colors.red[400],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pay",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Pallete.whiteColor.withAlpha(400),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "₹${outgoingAmount.abs().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
