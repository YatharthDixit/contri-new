import 'dart:io';
import 'package:contri/apis/auth_api.dart';
import 'package:contri/core/utils.dart';
import 'package:contri/theme/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectProfilePhotoScreen extends ConsumerStatefulWidget {
  Map<String, String> data;
  static const routeName = '/select-profile-photo-screen';

  SelectProfilePhotoScreen({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<SelectProfilePhotoScreen> createState() =>
      _SelectProfilePhotoScreenState();
}

class _SelectProfilePhotoScreenState
    extends ConsumerState<SelectProfilePhotoScreen> {
  File? profilePic;

  void selectImage() async {
    profilePic = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void storeUserData() {
    print(widget.data['name']);
    print(widget.data['phoneNumber']);
    ref.read(authAPIProvider).createUser(
        context, widget.data['name']!, widget.data['phoneNumber']!, profilePic);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.05,
                    // ),
                    // Image.asset(
                    //   "assets/photo.png",
                    //   width: size.width * 0.65,
                    // ),

                    const Text(
                      "So, How do you look?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Click on the image to select a picture or you can skip this step also.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),

                    ElevatedButton(
                      onPressed: selectImage,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), //<-- SEE HERE
                      ),
                      child: profilePic == null
                          ? const CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/imgs/profilepic.jpg",
                              ),
                              radius: 100,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(
                                profilePic!,
                              ),
                              radius: 100,
                            ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    SizedBox(
                      height: 50,
                      width: size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          // storeUserData();
                          AuthAPI().uploadImage(context, profilePic);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.pinkLightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: const Text(
                          "Finish",
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
          ),
        ));
  }
}
