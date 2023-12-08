import 'dart:convert';
import 'dart:io';

import 'package:contri/constants/constants.dart';
import 'package:contri/core/http_error_handeling.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/features/auth/controller/auth_controller.dart';
import 'package:contri/features/auth/view/enter_name.dart';
import 'package:contri/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authAPIProvider = Provider((ref) => AuthAPI());
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

abstract class IAuthAPI {
  Future<String> uploadImage(BuildContext context, File? image);
  void signIn(String phone, BuildContext context);
  void createUser(
      BuildContext context, String name, String phoneNumber, File? profile);
  Future<User?> getCurrentUser();
  // void getAdminData();
}

class AuthAPI implements IAuthAPI {
  @override
  Future<User?> getCurrentUser() async {
    try {
      print("Instde get user data");
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token != null) {
        print(token);
      }
      if (token == null) {
        pref.setString('x-auth-token', '');
        return null;
      }
      var tokenRes = await http.post(
          Uri.parse('${Constants.BASE_URL}/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);
      print(jsonDecode(tokenRes.body));

      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('${Constants.BASE_URL}/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });
        return User.fromJson(userRes.body);

        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void signIn(String OPTLessToken, BuildContext context) async {
    print("SIGNIN CALLED" + OPTLessToken);
    try {
      var body = jsonEncode({
        'token': OPTLessToken,
      });
      print("SIGNIN CALLED");
      print(jsonDecode(body));
      http.Response res = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/signin'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      print(jsonDecode(res.body));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            final data = jsonDecode(res.body);
            if (data['isRegistered']) {
              print("Inside signin if");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // Provider.of<UserProvider>(context, listen: false).setUser(res.body);
              await prefs.setString('x-auth-token', data['token']);
            } else {
              print("Inside signin else");

              Navigator.pushNamed(context, EnterNameScreen.routeName,
                  arguments: data['phoneNumber']);
            }
          });
    } catch (e) {
      // print(e);
      showSnackBar(context, e.toString());
    }
  }

  @override
  void createUser(BuildContext context, String name, String phoneNumber,
      File? profilePicture) async {
    try {
      String? profilePicURL = await uploadImage(context, profilePicture);
      print("GOT PROFILE URL" + profilePicURL);

      http.Response res = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/createAccount'),
        body: jsonEncode({
          'name': name,
          'phoneNumber': phoneNumber,
          'photoURL': profilePicURL,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            final data = jsonDecode(res.body);
            print(data);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('x-auth-token', data['token']);
          });
      print("USER SIGNUP AND LOGIN COMPLETE");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Future<String> uploadImage(BuildContext context, File? image) async {
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dzbgk67sd/upload');

      final http.MultipartRequest request = http.MultipartRequest('POST', url);

// Add form fields
      request.fields['upload_preset'] = 'contri-upload-image';

// Add file
      request.files.add(await http.MultipartFile.fromPath('file', image!.path));

// Send the request
      final http.Response response =
      await http.Response.fromStream(await request.send());
      print(jsonDecode(response.body)['secure_url']);

      return jsonDecode(response.body)['secure_url'];
    } catch (e) {
      print(e.toString());
      return 'https://res.cloudinary.com/dzbgk67sd/image/upload/v1702044411/contri-profile-pictures/default_profile_pic.jpg';
    }

    // return jsonDecode(response.body)['secure_url'];

// Use the response as nee
  }
}
