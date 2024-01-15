import 'package:contri/apis/expense_api.dart';
import 'package:contri/apis/friend_api.dart';
import 'package:contri/common/loader.dart';
import 'package:contri/features/expense/screens/expense_details.dart';
import 'package:contri/features/expense/widget/expense_row.dart';
import 'package:contri/models/user.dart';
import 'package:contri/theme/pallete.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsView extends ConsumerStatefulWidget {
  static const routeName = '/friends-details-screen';

  final User? friend;
  const FriendsView({required this.friend});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsViewState();
}

class _FriendsViewState extends ConsumerState<FriendsView> {
  double amount = 0;

  TextEditingController enteredAmount = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color iconColor(String i) {
    switch (i) {
      case 'Groceries':
        return Colors.cyan;
      case 'Home':
        return Colors.pink;
      case 'Travel':
        return Colors.blue;
      case 'Foods & Drinks':
        return Colors.orange;
      case 'Payments':
        return Colors.green;
      case 'Personal':
        return Colors.blue;
      case 'Shopping':
        return Colors.purple;
      case 'Others':
        return Colors.lime;
      default:
        return Colors.green;
    }
  }

  IconData icon(String i) {
    switch (i) {
      case 'Groceries':
        return Icons.breakfast_dining;
      case 'Home':
        return Icons.home;
      case 'Travel':
        return Icons.emoji_transportation;
      case 'Foods & Drinks':
        return Icons.restaurant;
      case 'Payments':
        return Icons.payment;
      case 'Personal':
        return Icons.person;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Others':
        return Icons.miscellaneous_services;
      default:
        return Icons.miscellaneous_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref
        .watch(friendBalanceProvider(widget.friend!.phoneNumber))
        .whenData((balance) {
      amount = balance;
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.greyBackgroundColor,
      appBar: AppBar(
        title: Text(widget.friend!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Pallete.blueLightColor,
                          Pallete.pinkLightColor,
                          Pallete.orangeLightColor
                        ]),
                    borderRadius: BorderRadius.circular(45)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Balance",
                          style: TextStyle(
                              color: Pallete.greyBackgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹${amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () async {},
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Pallete.whiteColor.withAlpha(70),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: const Center(
                                    child: Text(
                                      "Remind",
                                      style: TextStyle(
                                          color: Pallete.whiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  // enteredAmount.text = amount.abs().toString();
                                  // UserModel? adminUser = await getAdminUser();

                                  // showModalBottomSheet(
                                  //     isScrollControlled: true,
                                  //     context: context,
                                  //     backgroundColor: Colors.transparent,
                                  //     builder: (BuildContext context) => Padding(
                                  //           padding: EdgeInsets.only(
                                  //               bottom: MediaQuery.of(context)
                                  //                   .viewInsets
                                  //                   .bottom),
                                  //           child: Container(
                                  //             height: size.height * 0.4,
                                  //             decoration: const BoxDecoration(
                                  //                 color: whiteColor,
                                  //                 borderRadius: BorderRadius.only(
                                  //                     topLeft: Radius.circular(40),
                                  //                     topRight:
                                  //                         Radius.circular(40))),
                                  //             child: Column(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.spaceEvenly,
                                  //                 children: [
                                  //                   Text(
                                  //                     adminUser!.name,
                                  //                     style: TextStyle(
                                  //                         fontSize: 22,
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   ),
                                  //                   Text(
                                  //                     amount <= 0
                                  //                         ? "Paid to"
                                  //                         : "Recieved from",
                                  //                     style: TextStyle(
                                  //                         fontSize: 20,
                                  //                         color: greyLightColor
                                  //                             .shade600),
                                  //                   ),
                                  //                   Text(
                                  //                     user.name,
                                  //                     style: TextStyle(
                                  //                         fontSize: 22,
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   ),
                                  //                   Container(
                                  //                       height: 50,
                                  //                       width: size.width * 0.45,
                                  //                       decoration: BoxDecoration(
                                  //                           border: Border.all(
                                  //                               width: 1,
                                  //                               color:
                                  //                                   greyLightColor),
                                  //                           borderRadius:
                                  //                               BorderRadius
                                  //                                   .circular(80)),
                                  //                       child: Padding(
                                  //                         padding: const EdgeInsets
                                  //                                 .symmetric(
                                  //                             horizontal: 15),
                                  //                         child: Center(
                                  //                           child: Row(
                                  //                             children: [
                                  //                               Text("₹",
                                  //                                   style: TextStyle(
                                  //                                       fontSize:
                                  //                                           25)),
                                  //                               Expanded(
                                  //                                 child: TextField(
                                  //                                   controller:
                                  //                                       enteredAmount,
                                  //                                   keyboardType:
                                  //                                       TextInputType
                                  //                                           .number,
                                  //                                   style:
                                  //                                       const TextStyle(
                                  //                                           fontSize:
                                  //                                               20),
                                  //                                   decoration:
                                  //                                       const InputDecoration(
                                  //                                     border:
                                  //                                         InputBorder
                                  //                                             .none,
                                  //                                     hintText: "0",
                                  //                                     hintStyle:
                                  //                                         TextStyle(
                                  //                                             fontSize:
                                  //                                                 20),
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ],
                                  //                           ),
                                  //                         ),
                                  //                       )),
                                  //                   TextButton(
                                  //                       onPressed: () async {
                                  //                         UserModel? adminUser =
                                  //                             await getAdminUser();

                                  //                         Contact userContact =
                                  //                             Contact(phones: [
                                  //                           Phone(user.phoneNumber)
                                  //                         ]);
                                  //                         Contact adminUserContact =
                                  //                             Contact(phones: [
                                  //                           Phone(adminUser!
                                  //                               .phoneNumber)
                                  //                         ]);
                                  //                         amount <= 0
                                  //                             ? ref
                                  //                                 .read(
                                  //                                     expenseControllerProvider)
                                  //                                 .uploadExpense(
                                  //                                     context,
                                  //                                     "${adminUser.name} paid to ${user.name}",
                                  //                                     adminUser
                                  //                                         .phoneNumber,
                                  //                                     adminUser
                                  //                                         .phoneNumber,
                                  //                                     double.parse(
                                  //                                         enteredAmount
                                  //                                             .text),
                                  //                                     "Payments",
                                  //                                     {
                                  //                                       adminUserContact:
                                  //                                           0.toDouble(),
                                  //                                       userContact:
                                  //                                           double.parse(
                                  //                                               enteredAmount.text)
                                  //                                     },
                                  //                                     adminUser,
                                  //                                     true)
                                  //                             : ref
                                  //                                 .read(
                                  //                                     expenseControllerProvider)
                                  //                                 .uploadExpense(
                                  //                                     context,
                                  //                                     "${user.name} paid to ${adminUser.name}",
                                  //                                     user
                                  //                                         .phoneNumber,
                                  //                                     adminUser
                                  //                                         .phoneNumber,
                                  //                                     double.parse(
                                  //                                         enteredAmount
                                  //                                             .text),
                                  //                                     "Payments",
                                  //                                     {
                                  //                                       userContact:
                                  //                                           0.toDouble(),
                                  //                                       adminUserContact:
                                  //                                           double.parse(
                                  //                                               enteredAmount.text)
                                  //                                     },
                                  //                                     adminUser,
                                  //                                     true);
                                  //                         Navigator
                                  //                             .pushNamedAndRemoveUntil(
                                  //                                 context,
                                  //                                 HomeScreen
                                  //                                     .routeName,
                                  //                                 arguments:
                                  //                                     adminUser,
                                  //                                 (route) => false);
                                  //                       },
                                  //                       child: Container(
                                  //                         height:
                                  //                             size.height * 0.06,
                                  //                         width: size.width * 0.45,
                                  //                         decoration: BoxDecoration(
                                  //                             gradient: LinearGradient(
                                  //                                 begin: Alignment
                                  //                                     .topLeft,
                                  //                                 end: Alignment
                                  //                                     .bottomRight,
                                  //                                 colors: [
                                  //                                   blueLightColor,
                                  //                                   pinkLightColor
                                  //                                       .shade200,
                                  //                                   orangeLightColor
                                  //                                       .shade300
                                  //                                 ]),
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         26)),
                                  //                         child: const Center(
                                  //                             child: Text("Save",
                                  //                                 style: TextStyle(
                                  //                                     color:
                                  //                                         whiteColor,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500,
                                  //                                     fontSize:
                                  //                                         20))),
                                  //                       ))
                                  //                 ]),
                                  //           ),
                                  //         ));
                                  // // Dialogs.bottomMaterialDialog(
                                  // //     context: context,
                                  // //     title: amount <= 0
                                  // //         ? "Paying to ${user.name}"
                                  // //         : "Recieving from ${user.name}",
                                  // //     msg: amount <= 0
                                  // //         ? 'You are Paying ₹${amount.abs()} to ${user.name}'
                                  // //         : 'You are Recieving ₹${amount.abs()} from ${user.name}',
                                  // //     actions: [
                                  // //       TextButton(
                                  // //           onPressed: () async {

                                  // //               UserModel? adminUser =
                                  // //                   await getAdminUser();

                                  // //               Contact userContact = Contact(
                                  // //                   phones: [
                                  // //                     Phone(user.phoneNumber)
                                  // //                   ]);
                                  // //               Contact adminUserContact = Contact(
                                  // //                   phones: [
                                  // //                     Phone(adminUser!.phoneNumber)
                                  // //                   ]);
                                  // //               amount <= 0
                                  // //                   ? ref
                                  // //                       .read(
                                  // //                           expenseControllerProvider)
                                  // //                       .uploadExpense(
                                  // //                           context,
                                  // //                           "${adminUser.name} paid to ${user.name}",
                                  // //                           adminUser.phoneNumber,
                                  // //                           amount.abs(),
                                  // //                           "Payments", {
                                  // //                       adminUserContact:
                                  // //                           0.toDouble(),
                                  // //                       userContact: amount.abs()
                                  // //                     })
                                  // //                   : ref
                                  // //                       .read(
                                  // //                           expenseControllerProvider)
                                  // //                       .uploadExpense(
                                  // //                           context,
                                  // //                           "${user.name} paid to ${adminUser.name}",
                                  // //                           user.phoneNumber,
                                  // //                           amount.abs(),
                                  // //                           "Payments", {
                                  // //                       userContact: 0.toDouble(),
                                  // //                       adminUserContact: amount.abs()
                                  // //                     });
                                  // //               Navigator.pushNamed(
                                  // //                   context, HomeScreen.routeName,
                                  // //                   arguments: adminUser);
                                  // //           },
                                  // //           child: Container(
                                  // //             height: size.height * 0.05,
                                  // //             width: size.width * 0.45,
                                  // //             decoration: BoxDecoration(
                                  // //                 gradient: LinearGradient(
                                  // //                     begin: Alignment.topLeft,
                                  // //                     end: Alignment.bottomRight,
                                  // //                     colors: [
                                  // //                       blueLightColor,
                                  // //                       pinkLightColor.shade200,
                                  // //                       orangeLightColor.shade300
                                  // //                     ]),
                                  // //                 borderRadius:
                                  // //                     BorderRadius.circular(22)),
                                  // //             child: const Center(
                                  // //                 child: Text("Save",
                                  // //                     style: TextStyle(
                                  // //                         color: whiteColor,
                                  // //                         fontWeight:
                                  // //                             FontWeight.w500,
                                  // //                         fontSize: 20))),
                                  // //           ))
                                  // //     ]);
                                },
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Pallete.whiteColor.withAlpha(70),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: const Center(
                                    child: Text(
                                      "Settle",
                                      style: TextStyle(
                                          color: Pallete.whiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const Text(
                "Expenses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ref
                  .watch(friendExpensesProvider(widget.friend!.phoneNumber))
                  .when(data: (friendExpenses) {
                return Container(
                  // height: size.height * 0.11 * snapshot.data!.length,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (friendExpenses.length),
                      //  > 10
                      //     ? 10
                      //     : snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ref
                            .watch(expenseProvider(friendExpenses[index]))
                            .when(
                                data: (data) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            ExpenseDetailsScreen.routeName,
                                            arguments: data);
                                      },
                                      child: ExpenseRowWidget(
                                        description: data!.description,
                                        icon: icon(data.type),
                                        iconColor: iconColor(data.type),
                                        amount: data.totalAmount,
                                        date: data.date.format('j M y'),
                                      ),
                                    ),
                                  );
                                },
                                error: (error, stacktrace) => const Center(
                                    child: Text("Some error Occured")),
                                loading: () => const Loader());
                      }),
                );
              }, error: (error, stacktrace) {
                return Center(child: Text("Error1: $error"));
              }, loading: () {
                return Center(child: CircularProgressIndicator());
              }),
            ],
          ),
        ),
      )),
    );
  }
}
