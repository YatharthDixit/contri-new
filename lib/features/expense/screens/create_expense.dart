import 'package:chip_list/chip_list.dart';
import 'package:contri/contact/contact_api.dart';
import 'package:contri/contact/select_contact_controller.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/features/friends/screens/select_friends.dart';

import 'package:contri/features/home/screen/home_screeen.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-expense-screen';
  Map<String, dynamic> selectedContactAndIndex = {'contact': [], 'index': []};
  AddExpenseScreen({
    required this.selectedContactAndIndex,
    super.key,
  });

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen>
    with TickerProviderStateMixin {
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectContactsGroup(
            selectedContactAndIndex: widget.selectedContactAndIndex,
          ),
        ));
    // after the SecondScreen result comes back update the Text widget with it
  }

  void calculateTotalAmountPaid() {
    double totalAmountPaid =
        amountPaidPerPerson.values.fold(0.0, (sum, amount) => sum + amount);
    if (totalAmountPaid == amountDouble) {
      saveButtonText = "Save";
    } else {
      saveButtonText =
          "Balance: ${(amountDouble - totalAmountPaid).toStringAsFixed(2)}";
    }
  }

  Map<Contact, double> amountPaidPerPerson = {};
  String type = 'Others';
  String? category = "";
  int tag = 1;
  int singlePaidPersonIndex = 0;
  List<S2Choice<Contact>> personToPay = [];
  List<TextEditingController> spentPerPersonController = [];
  List<TextEditingController> amountPaidPerPersonConntroller = [];
  List<double> spentPerPerson = [];
  Map<Contact, double> selectedContactsAndPaidAmount = {};
  List<Contact> selectedContact = [];
  Map<Contact, double> selectedPeoples = {};
  List<int> catSelected = [0];
  List<TextEditingController> _paidPerPersonController = [];

  TextEditingController amount = TextEditingController(text: '0');
  TextEditingController name = TextEditingController();
  double splittingAmountSingle = 0;
  double customSplitBalance = 0;
  String saveButtonText = "Save";
  late TabController _paidTabController;
  late TabController _spentTabController;
  // late UserModel user;
  double amountDouble = 0;

  String paidByButtonText = "Save";

  void updatePaidSaveButtonText() {}

  @override
  void dispose() {
    // TODO: implement dispose
  }

  void showPaidByModalSheet(Size size) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => StatefulBuilder(builder: ((context, setState) {
              return Container(
                height: size.height * 0.07 * selectedContact.length +
                    size.height * 0.2,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: size.width * 0.95,
                        height: size.width * 0.08,
                        child: TabBar(
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          controller: _paidTabController,
                          labelColor: Colors.white,
                          onTap: (value) {
                            setState(() {});
                          },
                          unselectedLabelColor: Colors.black,

                          // isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              color: Pallete.pinkLightColor,
                              borderRadius: BorderRadius.circular(40)),

                          tabs: const [
                            Tab(
                              child: Center(
                                  child: Text(
                                "Single",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                            ),
                            Tab(
                              child: Center(
                                  child: Text(
                                "Multiple",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBarView(
                            controller: _paidTabController,
                            children: [
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: selectedContact.length,
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        setState(() {
                                          singlePaidPersonIndex = index;
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width: 35,
                                                    child: index ==
                                                            singlePaidPersonIndex
                                                        ? const Icon(
                                                            Icons.circle,
                                                            color: Pallete
                                                                .pinkColor,
                                                            size: 12,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .circle_outlined,
                                                            color: Pallete
                                                                .pinkColor,
                                                            size: 12,
                                                          )
                                                    // children: [
                                                    //   Icon(
                                                    //     Icons.circle,
                                                    //     size: 9,
                                                    //   ),
                                                    //   SizedBox(
                                                    //     width: 10,
                                                    //   ),
                                                    // ],
                                                    ),
                                                Expanded(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            selectedContact[
                                                                    index]
                                                                .displayName,
                                                            style: index ==
                                                                    singlePaidPersonIndex
                                                                ? const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)
                                                                : TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                        Text(
                                                          "₹${index - 1 == singlePaidPersonIndex ? int.parse(amount.text).toStringAsFixed(2) : "0.00"}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: selectedContact.length,
                                  itemBuilder: ((context, index) {
                                    amountPaidPerPersonConntroller
                                        .add(TextEditingController());

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    selectedContact[index]
                                                        .displayName,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                  width: size.width * 0.25,
                                                  height: size.height * 0.035,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "₹",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Pallete
                                                                        .greyColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0),
                                                            child: TextField(
                                                              onTap:
                                                                  _scrollDown,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              controller:
                                                                  amountPaidPerPersonConntroller[
                                                                      index],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (value) {
                                                                if (value
                                                                    .isNotEmpty) {
                                                                  selectedContactsAndPaidAmount[
                                                                      selectedContact[
                                                                          index]] = double
                                                                      .parse(
                                                                          value);
                                                                }
                                                                updatePaidSaveButtonText();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  })),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  @override
  void initState() {
    super.initState();
    _paidTabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _spentTabController =
        TabController(vsync: this, length: 2, initialIndex: 0);

    customSplitBalance = 0;

    // Phone p = Phone("+918960685939");

    // Contact c = Contact(displayName: "You", phones: [p]);

    // if (!selectedContacts.contains(c)) {
    //   selectedContacts.add(c);
    // }
  }

  void updateContacts() {}

  void uploadEqual(String name, double totalAmount, String cat) {
    // for (var i = 0; i < selectedContacts.length; i++) {
    //   selectedPeoples[selectedContacts[i]] = splittingAmountSingle;
    // }
    // createExpense(name, totalAmount, cat);
  }

  void uploadCustom(String name, double totalAmount, String cat) {
    // for (var i = 0; i < selectedContacts.length; i++) {
    //   selectedPeoples[selectedContacts[i]] = spentPerPerson[i];
    // }
    // createExpense(name, totalAmount, cat);
  }

  void splitEqually() {
    // try {
    //   if (selectedContactsAndPaidAmount.length == 1) {
    //     splittingAmountSingle = amountDouble;
    //   } else {
    //     splittingAmountSingle =
    //         amountDouble / selectedContactsAndPaidAmount.length;
    //   }
    // } catch (e) {
    //   splittingAmountSingle = 0;
    // }
  }

  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void splitCustom() {
    customSplitBalance = amountDouble;
    try {
      for (var i in spentPerPerson) {
        customSplitBalance = (customSplitBalance - i);
      }

      if (customSplitBalance != 0) {
        saveButtonText = "Balance: $customSplitBalance";
      } else {
        saveButtonText = "Save";
      }
    } catch (e) {
      if (amount.text == "") {
        showSnackBar(context, "Enter the Amount first.");
      }
    }
    setState(() {});
  }

  void createExpense(String name, double totalAmount, String cat) {
    // String currUserPhone =
    //     payingContact.phones[0].number.replaceAll(RegExp('[^+0-9]'), '');
    // if (!currUserPhone.startsWith("+91")) {
    //   currUserPhone = "+91$currUserPhone";
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    selectedContactsAndPaidAmount = ref.watch(selectedContactProvider).;

    selectedContact = selectedContactsAndPaidAmount.keys.toList();

    // TextEditingController _colorsTextEditingController =
    //     TextEditingController();
    // var _selectedColors;
    return Scaffold(
      backgroundColor: Pallete.greyBackgroundColor,
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
          title: const Text("Add Expense",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(children: [
                Container(
                    height: size.height * 0.10,
                    width: size.width * 0.65,
                    decoration: BoxDecoration(
                        color: Pallete.whiteColor,
                        borderRadius: BorderRadius.circular(60)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Center(
                        child: Row(
                          children: [
                            const Text(
                              "₹",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: TextField(
                                  controller: amount,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      amount.text.isEmpty
                                          ? amountDouble = 0
                                          : amountDouble = double.parse(value);
                                      _spentTabController.index == 0
                                          ? splitEqually()
                                          : splitCustom();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Pallete.whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21, right: 23),
                    child: Row(children: [
                      const Icon(
                        Icons.description,
                        color: Pallete.greyColor,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: name,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Notes"),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Pallete.whiteColor),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ChipList(
                        // shouldWrap: true,
                        listOfChipNames: expenseCategory,
                        borderRadiiList: const [30],
                        inactiveBorderColorList: const [
                          Pallete.greyBackgroundColor
                        ],
                        // wrapAlignment: WrapAlignment.spaceEvenly,
                        activeBgColorList: const [Pallete.pinkLightColor],
                        inactiveBgColorList: const [Colors.white],
                        activeTextColorList: const [Colors.white],

                        inactiveTextColorList: const [Colors.black],
                        listOfChipIndicesCurrentlySeclected: catSelected,
                        // borderColorList: [Theme.of(context).primaryColor],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.whiteColor,
                        elevation: 0,
                      ),
                      child: selectedContact.length < 2
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people_rounded,
                                      color: Pallete.greyColor,
                                    ),
                                    SizedBox(
                                      width: 26,
                                    ),
                                    Text(
                                      "Add People",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Pallete.greyColor,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Pallete.greyColor,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.people_rounded,
                                      color: Pallete.greyColor,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "${(selectedContact.length - 1).toString()} People Added",
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Pallete.greyColor,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                const Icon(
                                  Icons.navigate_next,
                                  color: Pallete.greyColor,
                                )
                              ],
                            ),
                      onPressed: () {
                        _awaitReturnValueFromSecondScreen(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                selectedContact.length < 2
                    ? const SizedBox()
                    : Container(
                        height: size.height * 0.09,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.whiteColor,
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Pallete.greyColor,
                                    ),
                                    SizedBox(
                                      width: 26,
                                    ),
                                    Text(
                                      "Paid by",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Pallete.greyColor,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Pallete.greyColor,
                                )
                              ],
                            ),
                            onPressed: () => showPaidByModalSheet(size),
                          ),
                        ),
                      ),

                //  SmartSelect<Contact>.single(
                //     modalType: S2ModalType.bottomSheet,
                //     choiceType: S2ChoiceType.chips,
                //     title: 'Paid by: ',
                //     onChange: (state) =>
                //         setState(() => payingContact = state.value),
                //     choiceStyle: S2ChoiceStyle(
                //       outlined: true,
                //       showCheckmark: true,
                //     ),
                //     selectedValue: payingContact,
                //     choiceItems: personToPay,
                //     tileBuilder: (context, state) => S2Tile.fromState(
                //           state,
                //           isTwoLine: true,
                //           leading: Container(
                //             width: 40,
                //             alignment: Alignment.center,
                //             child: const Icon(Icons.payment_rounded),
                //           ),
                //         )))

                SizedBox(
                  height: size.height * 0.03,
                ),
                selectedContact.length > 1
                    ? Container(
                        height: size.height * 0.275,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: size.width * 0.85,
                                height: size.width * 0.07,
                                child: TabBar(
                                  labelPadding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  controller: _spentTabController,
                                  labelColor: Colors.white,
                                  onTap: (value) {
                                    setState(() {});
                                  },
                                  unselectedLabelColor: Colors.black,
                                  // isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                      color: Pallete.pinkLightColor,
                                      borderRadius: BorderRadius.circular(60)),

                                  tabs: const [
                                    Tab(
                                      child: Center(
                                          child: Text(
                                        "Equally",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    ),
                                    Tab(
                                      child: Center(
                                          child: Text(
                                        "Custom",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TabBarView(
                                    controller: _spentTabController,
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: selectedContact.length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            selectedContact[
                                                                    index]
                                                                .displayName,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Text(
                                                            "₹${splittingAmountSingle.toStringAsFixed(2)}")
                                                      ]),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Divider()
                                                ],
                                              ),
                                            );
                                          })),
                                      ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: selectedContact.length,
                                          itemBuilder: ((context, index) {
                                            spentPerPerson.add(0);
                                            spentPerPersonController
                                                .add(TextEditingController());
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            selectedContact[
                                                                    index]
                                                                .displayName,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.25,
                                                          height: size.height *
                                                              0.035,
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                "₹",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border: Border
                                                                              .all(
                                                                            color:
                                                                                Pallete.greyColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      onTap:
                                                                          _scrollDown,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      controller:
                                                                          spentPerPersonController[
                                                                              index],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                              border: InputBorder.none),
                                                                      onChanged:
                                                                          (value) {
                                                                        value.isEmpty
                                                                            ? spentPerPerson[index] =
                                                                                0
                                                                            : spentPerPerson[index] =
                                                                                double.parse(value);
                                                                        splitCustom();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Divider()
                                                ],
                                              ),
                                            );
                                          })),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 1,
                      ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextButton(
                    onPressed: (() {
                      if (name.text.isNotEmpty && amount.text.isNotEmpty) {
                        if (_spentTabController.index == 0) {
                          uploadEqual(name.text, amountDouble,
                              expenseCategory[catSelected[0]]);
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        } else if (_spentTabController.index == 1) {
                          if (customSplitBalance == 0) {
                            uploadCustom(name.text, amountDouble,
                                expenseCategory[catSelected[0]]);
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomeScreen.routeName, (route) => false);
                          } else {
                            showSnackBar(context,
                                "Total amount is different from splitted amount.");
                          }
                        }
                      } else {
                        showSnackBar(context, "Enter required details.");
                      }
                    }),
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.65,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Pallete.blueLightColor,
                                Pallete.pinkLightColor,
                                Pallete.orangeLightColor
                              ]),
                          borderRadius: BorderRadius.circular(22)),
                      child: Center(
                        child: _spentTabController.index == 0
                            ? const Text("Save",
                                style: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20))
                            : Text(
                                saveButtonText,
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                      ),
                    )),
              ]),
            )),
      ),
    );
  }
}

List<String> expenseCategory = [
  'Groceries',
  'Home',
  'Travel',
  'Foods & Drinks',
  'Payments',
  'Personal',
  'Shopping',
  'Others'
];
