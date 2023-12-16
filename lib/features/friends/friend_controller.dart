import 'package:contri/apis/friend_api.dart';
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
