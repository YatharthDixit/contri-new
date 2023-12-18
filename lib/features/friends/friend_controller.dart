import 'package:contri/apis/friend_api.dart';
import 'package:contri/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final friendControllerProvider =
    StateNotifierProvider<FriendController, bool>((ref) {
  return FriendController(friendAPI: ref.watch(friendAPIProvider));
});

class FriendController extends StateNotifier<bool> {
  final FriendAPI _friendAPI;

  FriendController({required FriendAPI friendAPI})
      : _friendAPI = friendAPI,
        super(false);

  Future<List<String>> getFriends() async {
    List<String> friends = [];
    final res = await _friendAPI.getFriends();

    friends = res;

    return friends;
  }

  Future<double> getBalance(String friendPhone) async {
    double balance = 0.0;
    double result = await _friendAPI.getBalance(friendPhone);

    balance = result + 0.0;

    return balance;
  }

  Future<List<String>> getFriendExpenses(String friendPhone) async {
    List<String> expenses = [];
    final res = await _friendAPI.getFriendExpenses(friendPhone);

    expenses = res;

    return expenses;
  }
}

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(),
);
final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContactController(
    ref: ref,
    selectContactRepository: selectContactRepository,
  );
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  // void selectContact(Contact selectedContact, BuildContext context) {
  //   selectContactRepository.selectContact(selectedContact, context);
  // }

  // Future<List<Contact>> getContacts() {
  //   Future<List<Contact>> contacts = selectContactRepository.getContacts();
  //   return contacts;
  // }
//   void selectContact(Contact selectedContact, BuildContext context) async {
//     try {
//       // var userCollection = await firestore.collection('users').get();
//       bool isFound = false;

//       // for (var document in userCollection.docs) {
//       //   var userData = UserModel.fromMap(document.data());
//       //   String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(
//       //     ' ',
//       //     '',
//       //   );
//       //   if (selectedPhoneNum == userData.phoneNumber) {
//       //     isFound = true;
//       //     // Navigator.pushNamed(
//       //     //   context,
//       //     //   MobileChatScreen.routeName,
//       //     //   arguments: {
//       //     //     'name': userData.name,
//       //     //     'uid': userData.uid,
//       //     //   },
//       //     // );
//       //   }

//       if (!isFound) {
//         showSnackBar(
//           context,
//           'This number does not exist on this app.',
//         );
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
}

class SelectContactRepository {
  // final FirebaseFirestore firestore;

  // SelectContactRepository({
  //   // required this.firestore,
  // });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      print(e.toString());
    }
    return contacts;
  }

  // getContactMap(Future<List<Contact>> contactList) {}

  // void selectContact(Contact selectedContact, BuildContext context) async {
  //   // try {
  //   //   // var userCollection = await firestore.collection('users').get();
  //   //   bool isFound = false;

  //   //   for (var document in userCollection.docs) {
  //   //     var userData = UserModel.fromMap(document.data());
  //   //     String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(
  //   //       ' ',
  //   //       '',
  //   //     );
  //   //     if (selectedPhoneNum == userData.phoneNumber) {
  //   //       isFound = true;
  //   //       // Navigator.pushNamed(
  //   //       //   context,
  //   //       //   MobileChatScreen.routeName,
  //   //       //   arguments: {
  //   //       //     'name': userData.name,
  //   //       //     'uid': userData.uid,
  //   //       //   },
  //   //       // );
  //   //     }
  //   //   }

  //   //   if (!isFound) {
  //   //     showSnackBar(
  //   //       context: context,
  //   //       content: 'This number does not exist on this app.',
  //   //     );
  //   //   }
  //   // } catch (e) {
  //   //   showSnackBar(context: context, content: e.toString());
  //   // }
  // }
}
