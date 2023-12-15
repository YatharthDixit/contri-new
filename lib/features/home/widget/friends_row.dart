import 'package:contri/common/loader.dart';
import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
// import 'package:contri/models/user_model.dart';
// import 'package:contri/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRow extends ConsumerStatefulWidget {
  final User? user;
  final double amount;
  const FriendRow({
    Key? key,
    required this.user,
    required this.amount,
  }) : super(key: key);

  @override
  ConsumerState<FriendRow> createState() => _FriendRowState();
}

class _FriendRowState extends ConsumerState<FriendRow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return widget.user == null
        ?  const Loader()
        : Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
            child: Column(
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
                              CircleAvatar(
                                foregroundImage:
                                    NetworkImage(widget.user!.photoURL),
                                radius: 25,
                              ),
                               const SizedBox(
                                width: 15,
                              ),
                              Text(
                                widget.user!.name,
                                style: const  TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '₹${widget.amount.toStringAsFixed(2)}',
                                style:  const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                               const SizedBox(
                                height: 4,
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
          );
  }
}
