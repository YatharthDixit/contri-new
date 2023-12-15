import 'package:contri/theme/pallete.dart';
import 'package:flutter/cupertino.dart';

class ExpenseRowWidget extends StatelessWidget {
  final icon;
  final description;
  final amount;
  final date;
  final iconColor;
  const ExpenseRowWidget({
    super.key,
    required this.icon,
    required this.description,
    required this.amount,
    required this.date,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: size.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Pallete.whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [iconColor[200], iconColor[600]])),
                        child: Icon(
                          icon,
                          color: Pallete.whiteColor,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: size.width * 0.3,
                        child: Text(
                          description,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                          softWrap: false,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        amount.toString(),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 15,
                          color: Pallete.greyColor,
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
