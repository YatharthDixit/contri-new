import 'package:contri/apis/auth_api.dart';
import 'package:contri/common/loader.dart';
import 'package:contri/features/expense/widget/expense_person_row.dart';
import 'package:contri/features/expense/widget/expense_status_card.dart';
import 'package:contri/models/expense.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseDetailsScreen extends ConsumerStatefulWidget {
  final Expense expense;
  // final Map<String, dynamic> details;
  const ExpenseDetailsScreen({super.key, required this.expense});
  static const routeName = '/expense-details-screen';

  @override
  ConsumerState<ExpenseDetailsScreen> createState() =>
      _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends ConsumerState<ExpenseDetailsScreen> {
  late Expense expense = widget.expense;

  void getCurrentUser() {}

  List<String> userNumberList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expense = widget.expense;
    userNumberList = expense.userSpent.keys.toList();
    print(userNumberList);

    // getAdminUser();
  }

  void deleteExpense() {}

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    //

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: const Text("Details",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return
                          // false ? Container(
                          //         height: size.height * 0.25,
                          //         decoration: const BoxDecoration(
                          //             color: Pallete.whiteColor,
                          //             borderRadius: BorderRadius.only(
                          //                 topLeft: Radius.circular(40),
                          //                 topRight: Radius.circular(40))),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 20.0, horizontal: 28),
                          //           child: Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Text(
                          //                 "Oops!",
                          //                 style: TextStyle(
                          //                     fontSize: 22,
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               Text(
                          //                 "Only the person who created the expense can delete the expense.",
                          //                 style: TextStyle(
                          //                     fontSize: 18,
                          //                     color: Pallete.greyColor
                          //                     fontWeight: FontWeight.w500),
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //               TextButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: Container(
                          //                     height: size.height * 0.05,
                          //                     width: size.width * 0.4,
                          //                     decoration: BoxDecoration(
                          //                         gradient: LinearGradient(
                          //                             begin: Alignment.topLeft,
                          //                             end: Alignment.bottomRight,
                          //                             colors: [
                          //                               Pallete.blueLightColor,
                          //                              Pallete.pinkLightColor,
                          //                               Pallete.orangeLightColor
                          //                             ]),
                          //                         borderRadius:
                          //                             BorderRadius.circular(26)),
                          //                     child: const Center(
                          //                         child: Text("Okay",
                          //                             style: TextStyle(
                          //                                 color: Pallete.whiteColor ,
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 20))),
                          //                   )),
                          //             ],
                          //           ),
                          //         ))
                          // :
                          Container(
                              height: size.height * 0.25,
                              decoration: const BoxDecoration(
                                  color: Pallete.whiteColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 28),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Confirm Delete",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Expense will be deleted for everyone in this expense.",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Pallete.greyColor,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: deleteExpense,
                                        child: Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Pallete.blueLightColor,
                                                    Pallete.pinkLightColor,
                                                    Pallete.orangeLightColor
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(26)),
                                          child: const Center(
                                              child: Text("Confirm",
                                                  style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20))),
                                        )),
                                  ],
                                ),
                              ));
                    });
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
            child: Center(
                child: Column(
              children: [
                ExpenseStatusCard(
                  expense: expense,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Pallete.whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Paid By",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: expense.userPaid.length,
                            itemBuilder: (context, index) {
                              // var user = ref
                              //     .read(authControllerProvider)
                              //     .getUserDataUid(userNumberList[index]);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GestureDetector(
                                        onTap: () {
                                          // if (expense.userSpent[index] != currentUser) {
                                          //   Navigator.pushNamed(
                                          //       context, FriendsView.routeName,
                                          //       arguments: {
                                          //         'user': allUsers[index],
                                          //         'amount':
                                          //             currentUser!.friendList[
                                          //                 allUsers[index]
                                          //                     .phoneNumber]!
                                          //       });
                                          // } else {
                                          //   showSnackBar(
                                          //        context,
                                          //        "This is You.");
                                          // }
                                        },
                                        child: ref
                                            .watch(userDataProvider(expense
                                                .userPaid.keys
                                                .toList()[index]))
                                            .when(data: (user) {
                                          print(expense);
                                          return ExpensePerson(
                                            user: user!,
                                            amount: expense.userPaid[expense
                                                .userPaid.keys
                                                .toList()[index]]!,
                                          );
                                        }, error: (error, stacktrace) {
                                          return const Text(
                                              "Some error Occured");
                                        }, loading: () {
                                          return const Loader();
                                        })),
                                  ),
                                  const Divider(),
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  // height: (size.height * 0.09) * 4 + size.height * 0.02,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Pallete.whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Splitted among",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          // height: (size.height * 0.08) * allUsers.length,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: expense.userSpent.length,
                              itemBuilder: (context, index) {
                                // var user = ref
                                //     .read(authControllerProvider)
                                //     .getUserDataUid(userNumberList[index]);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: GestureDetector(
                                          onTap: () {
                                            // if (expense.userSpent[index] != currentUser) {
                                            //   Navigator.pushNamed(
                                            //       context, FriendsView.routeName,
                                            //       arguments: {
                                            //         'user': allUsers[index],
                                            //         'amount':
                                            //             currentUser!.friendList[
                                            //                 allUsers[index]
                                            //                     .phoneNumber]!
                                            //       });
                                            // } else {
                                            //   showSnackBar(
                                            //        context,
                                            //        "This is You.");
                                            // }
                                          },
                                          child: ref
                                              .watch(userDataProvider(expense
                                                  .userSpent.keys
                                                  .toList()[index]))
                                              .when(data: (user) {
                                            return ExpensePerson(
                                              user: user!,
                                              amount: expense.userSpent[expense
                                                  .userSpent.keys
                                                  .toList()[index]]!,
                                            );
                                          }, error: (error, stacktrace) {
                                            return const Text(
                                                "Some error Occured");
                                          }, loading: () {
                                            return const Loader();
                                          })),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
