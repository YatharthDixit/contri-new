import 'package:contri/apis/auth_api.dart';
import 'package:contri/apis/friend_api.dart';
import 'package:contri/common/loader.dart';
import 'package:contri/features/friends/screens/friend_screen.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRowWidget extends ConsumerWidget {
  final String friendPhone;
  const FriendRowWidget({
    super.key,
    required this.friendPhone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Pallete.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ref.watch(userDataProvider(friendPhone)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      FriendsView.routeName,
                      arguments: user,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: NetworkImage(user!.photoURL),
                            radius: 25,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ref.watch(friendBalanceProvider(friendPhone)).when(
                                data: (balance) {
                                  return Text(
                                    '₹${balance.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                                error: (error, stacktrace) {
                                  return const Text(
                                    '0',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                                loading: () => const Loader(),
                              ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              error: (error, stacktrace) {
                return const Text("Error");
              },
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
