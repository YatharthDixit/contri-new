import 'package:contri/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(),
);

final selectedContactProvider =
    StateNotifierProvider<SelectedContactNotifier, Map<Contact, double>>(
  (ref) {
    var user = ref.read(currentUserAccountProvider).value;

    if (user == null) return SelectedContactNotifier({});
    Contact currectUserContact =
        Contact(phones: [Phone(user.phoneNumber)], displayName: "You");
    return SelectedContactNotifier({currectUserContact: 0});
  },
);

class SelectedContactNotifier extends StateNotifier<Map<Contact, double>> {
  SelectedContactNotifier(super._state, {state});

  void addContact(Contact contact) {
    Map<Contact, double> temp = state;
    if (temp.containsKey(contact)) {
      temp.remove(contact);
    } else {
      temp[contact] = 0;
    }
    state = temp;
  }

  void updateAmount(Contact selectedContact, double updatedAmount) {
    Map<Contact, double> temp = state;
    temp[selectedContact] = updatedAmount;

    state = temp;
  }
}

class SelectContactRepository {
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
        // print(contacts);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  getContactMap(Future<List<Contact>> contactList) {}
}
