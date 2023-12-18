import 'package:chip_list/chip_list.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/features/friends/friend_controller.dart';
import 'package:contri/features/friends/screens/select_mutiple.dart';
import 'package:contri/features/home/screen/home_screeen.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  Map<String, dynamic> selectedContactAndIndex;

  static const routeName = '/add-expense-screen';

  AddExpenseScreen({super.key, required this.selectedContactAndIndex});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen>
    with SingleTickerProviderStateMixin {
  List<S2Choice<Contact>> personToPay = [];
  List<TextEditingController> amountPerPersonController = [];
  List<double> amountPerPerson = [];
  late Contact payingContact =
      Contact(displayName: "You", phones: [Phone('+918960685939')]);
  TextEditingController amount = TextEditingController();
  TextEditingController name = TextEditingController();
  late double splittingAmountSingle;
  double customSplitBalance = 0;
  String saveButtonText = "Save";
  late TabController _tabController;
  // late UserModel user;
  double amountDouble = 0;
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);

    customSplitBalance = 0;

    Phone p = Phone("+918960685939");

    Contact c = Contact(displayName: "You", phones: [p]);

    if (!selectedContacts.contains(c)) {
      selectedContacts.add(c);
    }
  }

  void uploadEqual(String name, double totalAmount, String cat) {
    for (var i = 0; i < selectedContacts.length; i++) {
      selectedPeoples[selectedContacts[i]] = splittingAmountSingle;
    }
    createExpense(name, totalAmount, cat);
  }

  void uploadCustom(String name, double totalAmount, String cat) {
    for (var i = 0; i < selectedContacts.length; i++) {
      selectedPeoples[selectedContacts[i]] = amountPerPerson[i];
    }
    createExpense(name, totalAmount, cat);
  }

  List<dynamic> selectedContacts = [];
  Map<Contact, double> selectedPeoples = Map();
  List<int> catSelected = [0];

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectContactsGroup(
            selectedContactAndIndex: widget.selectedContactAndIndex,
          ),
        ));

    // // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (result != null) {
        widget.selectedContactAndIndex = result!;
        selectedContacts = widget.selectedContactAndIndex['contact']!;
        personToPay = [];
        for (Contact i in selectedContacts) {
          personToPay.add(S2Choice(value: i, title: i.displayName.toString()));
        }
      }
      splitEqually();
    });
  }

  Map<int, String> allContacts = {};
  void getAllContacts() {
    return ref.watch(getContactsProvider).when(
          data: (contactList) {
            contactList = contactList;
          },
          loading: () {},
          error: (error, stackTrace) {},
        );
  }

  void splitEqually() {
    try {
      if (selectedContacts.length == 1) {
        splittingAmountSingle = amountDouble;
      } else {
        splittingAmountSingle = amountDouble / selectedContacts.length;
      }
    } catch (e) {
      splittingAmountSingle = 0;
    }
  }

  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void splitCustom() {
    customSplitBalance = amountDouble;
    try {
      for (var i in amountPerPerson) {
        customSplitBalance = (customSplitBalance - i);
      }

      if (customSplitBalance != 0) {
        saveButtonText = "Balance: ${customSplitBalance}";
      } else {
        saveButtonText = "Save";
      }
    } catch (e) {
      if (amount.text == "") {
        showSnackBar(context, "Enter the Amount first.");
      }
      ;
    }
    setState(() {});
  }

  void createExpense(String name, double totalAmount, String cat) {
    String currUserPhone =
        payingContact.phones[0].number.replaceAll(RegExp('[^+0-9]'), '');
    if (!currUserPhone.startsWith("+91")) {
      currUserPhone = "+91$currUserPhone";
    }
    //   ref.read(expenseControllerProvider).uploadExpense(
    //       context,
    //       name,
    //       currUserPhone,
    //       FirebaseAuth.instance.currentUser!.phoneNumber!,
    //       totalAmount,
    //       cat,
    //       selectedPeoples,
    //       user,
    //       false);
    //   ref.read(selectedGroupContacts.state).update((state) => []);
    // }
  }

  String type = 'Others';
  String? category = "";
  int tag = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // TextEditingController _colorsTextEditingController =
    //     TextEditingController();
    // var _selectedColors;
    return Scaffold(
      backgroundColor: Pallete.greyBackgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
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
                                      _tabController.index == 0
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
                      Icon(
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
                        borderRadiiList: [30],
                        inactiveBorderColorList: [Pallete.greyBackgroundColor],
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
                      child: selectedContacts.length < 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people_rounded,
                                      color: Pallete.greyColor,
                                    ),
                                    const SizedBox(
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
                                    Icon(
                                      Icons.people_rounded,
                                      color: Pallete.greyColor,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "${(selectedContacts.length - 1).toString()} People Added",
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
                      onPressed: () {
                        _awaitReturnValueFromSecondScreen(context);

                        _scrollDown();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                selectedContacts.length < 2
                    ? SizedBox()
                    : Container(
                        height: size.height * 0.09,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: SmartSelect<Contact>.single(
                            modalType: S2ModalType.bottomSheet,
                            choiceType: S2ChoiceType.chips,
                            title: 'Paid by: ',
                            onChange: (state) =>
                                setState(() => payingContact = state.value),
                            choiceStyle: S2ChoiceStyle(
                              outlined: true,
                              showCheckmark: true,
                            ),
                            selectedValue: payingContact,
                            choiceItems: personToPay,
                            tileBuilder: (context, state) => S2Tile.fromState(
                                  state,
                                  isTwoLine: true,
                                  leading: Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.payment_rounded),
                                  ),
                                ))),
                SizedBox(
                  height: size.height * 0.03,
                ),
                selectedContacts.length > 1
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
                              Container(
                                width: size.width * 0.85,
                                height: size.width * 0.07,
                                child: TabBar(
                                  labelPadding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  controller: _tabController,
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

                                  tabs: [
                                    Tab(
                                      child: Container(
                                        child: const Center(
                                            child: Text(
                                          "Equally",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(60)),
                                        child: const Center(
                                            child: Text(
                                          "Custom",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        )),
                                      ),
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
                                    controller: _tabController,
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: selectedContacts.length,
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
                                                        selectedContacts[index]
                                                                is String
                                                            ? const Text("You",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                            : Text(
                                                                selectedContacts[
                                                                        index]
                                                                    .displayName,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                        Text(
                                                            "₹${splittingAmountSingle.toStringAsFixed(2)}")
                                                      ]),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                                      ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: selectedContacts.length,
                                          itemBuilder: ((context, index) {
                                            amountPerPerson.add(0);
                                            amountPerPersonController.add(
                                                new TextEditingController());
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
                                                            selectedContacts[
                                                                    index]
                                                                .displayName,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Container(
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
                                                                          amountPerPersonController[
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
                                                                            ? amountPerPerson[index] =
                                                                                0
                                                                            : amountPerPerson[index] =
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
                        if (_tabController.index == 0) {
                          uploadEqual(name.text, amountDouble,
                              expenseCategory[catSelected[0]]);
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        } else if (_tabController.index == 1) {
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
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Pallete.blueLightColor,
                                Pallete.pinkLightColor,
                                Pallete.orangeLightColor
                              ]),
                          borderRadius: BorderRadius.circular(22)),
                      child: Center(
                        child: _tabController.index == 0
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
