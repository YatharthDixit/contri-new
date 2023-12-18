import 'package:contri/common/loader.dart';
import 'package:contri/features/expense/screens/create_expense.dart';
import 'package:contri/features/friends/friend_controller.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  Map<String, dynamic> selectedContactAndIndex = {"contact": [], "index": []};
  static const routeName = '/add-people-screen';

  SelectContactsGroup({super.key, required this.selectedContactAndIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<dynamic> selectedContactsIndex = [];
  TextEditingController searchController = TextEditingController();
  List<dynamic> selectedContacts = [];
  List<Contact> allContact = [];
  late List<Contact> foundContact = allContactList;

  @override
  initState() {
    super.initState();

    foundContact = allContactList;

    // String phone = FirebaseAuth.instance.currentUser!.phoneNumber.toString();

    // if (widget.selectedContactAndIndex['index'] != null)
    selectedContactsIndex = widget.selectedContactAndIndex['index'] ?? [];
    Phone p = Phone('+918960685939');

    Contact c = Contact(displayName: "You", phones: [p]);

    selectedContacts = widget.selectedContactAndIndex['contact'] ?? [];
    if (!selectedContacts.contains(c)) {
      selectedContacts.add(c);
    }
  }

  List<Contact> allContactList = [];
  var isInitiated = false;
  void searchList(String enteredKeyword) {
    List<Contact> results = [];
    if (enteredKeyword.isEmpty) {
      results = allContactList;
    } else {
      results = allContactList
          .where((xyz) => xyz.displayName
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundContact = results;
    });
  }

  void selectContact(String index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.remove(index);
      selectedContacts.remove(contact);
    } else {
      selectedContactsIndex.add(index);
      selectedContacts.add(contact);
    }
    setState(() {});
    ref
        .read(selectedGroupContacts.state)
        .update((state) => [...state, contact]);
  }

  void getContactList() {
    ref.watch(getContactsProvider).when(
          data: (contactList) {
            allContactList = contactList;
            var length = allContactList.length;
            for (var i = 0; i < length; i++) {
              if (allContactList[i].phones.length > 1) {
                for (var j = 0; j < allContactList[i].phones.length; j++) {
                  allContactList.insert(
                      i,
                      Contact(
                          name: allContactList[i].name,
                          phones: [allContactList[i].phones[j]]));
                  length++;
                }
              }
            }
            if (!isInitiated) {
              isInitiated = true;
              foundContact = allContactList;
            }
          },
          error: (err, trace) => Text(
            err.toString(),
          ),
          loading: () => const Loader(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(getContactsProvider).whenData((value) {
      allContact = value;
    });
    final size = MediaQuery.of(context).size;

    var greyLightColor;
    getContactList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context,
                {"contact": selectedContacts, "index": selectedContactsIndex});
          },
          child: Container(
            height: 70,
            width: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Pallete.blueLightColor,
                      Pallete.pinkLightColor,
                      Pallete.orangeLightColor
                    ]),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
                child: Text("Save",
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20))),
          )),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  AddExpenseScreen.routeName,
                  arguments: selectedContacts,
                  (route) => false);
              print(selectedContacts.length);
              Navigator.pop(context, {
                "contact": selectedContacts,
                "index": selectedContactsIndex
              });
            },
            color: Colors.black,
          ),
          title: const Text("Select Peoples",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Container(
              // height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
                // color: Colors.grey.shade300
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchList(value);
                      },
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search with name"),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: foundContact.length,
                itemBuilder: (context, index) {
                  // var currPhone = foundContact[index].phones[0].toString();

                  final contact = foundContact[index];
                  return foundContact[index].phones.isNotEmpty
                      ? InkWell(
                          onTap: () => selectContact(
                              foundContact[index].phones[0].number.toString(),
                              contact),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  contact.displayName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(contact.phones[0].number),
                                trailing: selectedContactsIndex.contains(
                                        foundContact[index]
                                            .phones[0]
                                            .number
                                            .toString())
                                    ? IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.check_circle,
                                          color: Colors.black54,
                                        ),
                                      )
                                    : null,
                                leading: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey.shade700,
                                  child: const Icon(
                                    Icons.person,
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        );
                }),
          ),
        ],
      ),
    );
  }
}
