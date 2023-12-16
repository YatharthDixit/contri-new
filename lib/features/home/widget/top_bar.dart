import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';

import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  final User user;

  const HomeTopBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.077,
      child: Row(children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, ProfileView.routeName,
            //     arguments: user);
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
            radius: 25,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        // ignore: prefer_const_literals_to_create_immutables
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome!",
                style: TextStyle(
                    fontSize: 14,
                    color: Pallete.greyColor,
                    fontWeight: FontWeight.w400)),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ]),
    );
  }
}
