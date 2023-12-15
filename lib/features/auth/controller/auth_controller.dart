import 'dart:io';

import 'package:contri/apis/auth_api.dart';
import 'package:contri/core/failure.dart';
import 'package:contri/core/type_defs.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<AuthController, bool> authControllerProvider =
    StateNotifierProvider(
        (ref) => AuthController(authAPI: ref.watch(authAPIProvider)));

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
  Future<User?> currentUser() => _authAPI.getCurrentUser();
  Future<User?> getUserData(String phoneNumber) => _authAPI.getUserData( phoneNumber);
  


  void signInUser(BuildContext context, String OTPLessToken) async {
    state = true;

    _authAPI.signIn(OTPLessToken, context);
    state = false;
  }

  void createUser(BuildContext context, String name, String phoneNumber, File? profilePicture) {
    state = true;
    _authAPI.createUser(context, name, phoneNumber, profilePicture);
    state = false;
  }
  // void signInUser({
  //   required String phoneNumber,
  //   required BuildContext context,
  // }) async {
  //   state = true;
  //   final resToken =
  //       await _authAPI.signInUser(phoneNumber: '+91$phoneNumber');
  //   resToken.fold((l) {
  //     state = false;
  //     showSnackBar(context, l.message);
  //   }, (r) {
  //     state = false;
  //     Navigator.of(context).pushNamed('/otp-screen', arguments: r);
  //   });
  // }
  // FutureEither<Token> requestOTP({
  //   required String phoneNumber,
  //   required BuildContext context,
  // }) async {
  //   state = true;
  //   final resToken =
  //       await _authAPI.requestOTP(phoneNumber: '+91$phoneNumber');
  //   return resToken.fold((l) {
  //     return left(Failure(l.message, l.stackTrace));
  //   }, (r) {
  //     state = false;
  //     return right(r);
  //   });
  // }
}
