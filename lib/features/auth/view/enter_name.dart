import 'package:contri/common/loader.dart';
import 'package:contri/features/auth/controller/auth_controller.dart';
import 'package:contri/features/auth/view/select_image.dart';
import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterNameScreen extends ConsumerStatefulWidget {
  static const routeName = '/enter-name-screen';
  final String phoneNumber;

  const EnterNameScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends ConsumerState<EnterNameScreen> {
  TextEditingController enteredName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Loader()
        : Scaffold(
            body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.05,
                    // ),
                    Image.asset(
                      "assets/imgs/hello.png",
                      width: size.width * 0.8,
                    ),

                    const Text(
                      "Hi, Welcome to Contri!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "What's your name?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                        height: 55,
                        width: size.width * 0.75,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Pallete.greyBackgroundColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 3),
                          child: Center(
                            child: TextField(
                              controller: enteredName,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(fontSize: 22),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (enteredName.text.isNotEmpty) {
                            Map<String, String> data = {
                              "name": enteredName.text,
                              "phoneNumber": widget.phoneNumber
                            };

                            Navigator.pushNamed(
                                context, SelectProfilePhotoScreen.routeName,
                                arguments: data);
                            // ref
                            //     .read(authControllerProvider.notifier)
                            //     .createUser(context, enteredName.text,
                            //         widget.phoneNumber);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.pinkLightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ]),
            )),
          ));
  }
}
