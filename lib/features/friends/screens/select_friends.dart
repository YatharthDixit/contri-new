import 'dart:ffi';
import 'dart:math';

import 'package:contri/contact/contact_api.dart';
import 'package:contri/contact/select_contact_controller.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/loader.dart';

final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  Map<String, dynamic> selectedContactAndIndex = {'contact': [], 'index': []};
  static const routeName = '/add-people-screen';

  SelectContactsGroup({super.key, required this.selectedContactAndIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<dynamic> selectedContactsIndex = [];
  TextEditingController searchController = TextEditingController();
  Map<Contact, double> selectedContacts = {};
  late List<dynamic> allContact;
  late List<Contact> foundContact = allContactList;

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
    // selectedContactsIndex.add(index);
    ref.read(selectedContactProvider.notifier).addContact(contact);
    // selectedContacts.add(contact);

    setState(() {});
    ref
        .read(selectedGroupContacts.notifier)
        .update((state) => [...state, contact]);
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    selectedContacts = ref.watch(selectedContactProvider);
    print(allContactList);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Pallete.blueLightColor,
                      Pallete.pinkLightColor,
                      Pallete.orangeLightColor
                    ]),
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(
              Icons.save,
              color: Pallete.whiteColor,
            )),
          )),
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
          ref.watch(getContactsProvider).when(error: (e, st) {
            return Center(
              child: Text(
                e.toString(),
              ),
            );
          }, loading: () {
            return const Loader();
          }, data: (data) {
            allContactList = data;

            if (!isInitiated) {
              isInitiated = true;
              foundContact = allContactList;
            }

            return Expanded(
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
                                  trailing: selectedContacts
                                          .containsKey(foundContact[index])
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
            );
          })
        ],
      ),
    );
  }
}
