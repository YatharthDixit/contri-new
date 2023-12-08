import 'package:contri/common/loader.dart';
import 'package:contri/core/utils.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:contri/features/auth/controller/auth_controller.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//        7faaec90b6c1453dab71b1e4f4f3de51
class LoginView extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _phoneController = TextEditingController();
  final _otplessFlutterPlugin = Otpless();
  var extra = {
    "method": "get",
    "param": {"cid": "1LIU9KE1XRPOHH3LRYS206EQBL5HR68E"}
  };

  void requestSignIN() async {
    await _otplessFlutterPlugin.openLoginPage(
      (result) {
        if (result['data'] != null) {
          final token = result['data']['token'];
          print(token);
          // AuthAPI().signIn(token, context);
          ref.read(authControllerProvider.notifier).signInUser(context, token);
        } else {
          showSnackBar(context, result['errorMessage']);
        }
      },
    );
    // ref
    //     .read(authControllerProvider.notifier)
    //     .signInUser(context, 'YatharthDixit');
    //     d499e511885e4d9ab9cd028f1be23cb9

    // AuthAPI().signIn('bb16db1f23d74accb3fefda4bf6a491e', context);
    // print(js)
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Loader()
        : Scaffold(
            body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(
                      //   height: size.height * 0.05,
                      // ),

                      const Column(
                        children: [
                          Text(
                            "Phone Verification",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Please login or signup to continue.',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/imgs/login.png",
                        width: size.width * 0.77,
                      ),
                      // Form(
                      //   key: _singupFormKey,
                      //   child: TextFormField(
                      //     controller: _phoneController,
                      //     keyboardType: TextInputType.phone,
                      //     style: TextStyle(fontSize: 20),
                      //     decoration: InputDecoration(
                      //       alignLabelWithHint: false,

                      //       // hintText: "Phone Number",
                      //       prefix: Text("+91 "),
                      //       // hintFadeDuration: Duration(milliseconds: 50),
                      //       labelText: "  Phone Number",
                      //       errorStyle: TextStyle(fontSize: 14),
                      //       focusedErrorBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Pallete.pinkLightColor, width: 2.5),
                      //         borderRadius: BorderRadius.circular(
                      //           12,
                      //         ),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Pallete.pinkLightColor, width: 1.5),
                      //         borderRadius: BorderRadius.circular(
                      //           12,
                      //         ),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Pallete.greyColor),
                      //         borderRadius: BorderRadius.circular(
                      //           12,
                      //         ),
                      //       ),
                      //     ),
                      //     validator: (val) {
                      //       if (val == null || val.isEmpty) {
                      //         return 'Enter your phone number';
                      //       } else if (val.startsWith('0')) {
                      //         return "Number can not start with 0";
                      //       } else if (val.length != 10)
                      //         return "Number should be of 10 digits";

                      //       return null;
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 50,
                        width: size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: requestSignIN,
                          //     () {
                          //   _otplessFlutterPlugin.start((result) {
                          //     var message = "";
                          //     if (result['data'] != null) {
                          //       final token = result['data']['token'];
                          //       message = "token: $token";
                          //     } else {
                          //       message = result['errorMessage'];
                          //     }
                          //   }, jsonObject: extra);
                          // },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.pinkColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ));
  }
}
