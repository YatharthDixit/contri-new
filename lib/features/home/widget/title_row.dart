import 'package:flutter/material.dart';

// import '../../../utils/constants.dart';

class PageTitleRow extends StatelessWidget {
  final String text;
  const PageTitleRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // TextButton(
        //     onPressed: () async {},
        //     child: Text(
        //       "View All",
        //       style: TextStyle(color: greyLightColor[600], fontSize: 15),
        //     )),
      ],
    );
  }
}
