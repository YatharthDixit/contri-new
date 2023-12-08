// import 'package:contri/theme/pallete.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';

// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: Pallete.greyBackgroundColor),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Pallete.pinkLightColor),
//       borderRadius: BorderRadius.circular(8),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );

//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_rounded),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             color: Colors.black,
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//                 child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // SizedBox(
//                     //   height: size.height * 0.05,
//                     // ),
//                     Image.asset(
//                       "assets/login.png",
//                       width: size.width * 0.57,
//                     ),

//                     const Text(
//                       'Phone Verification',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Text(
//                       'We need to register your phone before getting started!',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),

//                     Pinput(
//                       length: 6,
//                       defaultPinTheme: defaultPinTheme,
//                       focusedPinTheme: focusedPinTheme,
//                       submittedPinTheme: submittedPinTheme,
//                       pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                       showCursor: true,
//                       // onChanged: (value) {
//                       //   if (value.length == 6) {
//                       //     verifyOTP(ref, context, value);
//                       //     showSnackBar(
//                       //         context: context,
//                       //         content: "Trying to signin/signup.");
//                       //   }
//                       // },
//                     ),
//                     SizedBox(
//                       height: size.height * 0.1,
//                     ),
//                     // SizedBox(
//                     //   height: 50,
//                     //   width: size.width * 0.8,
//                     //   child: ElevatedButton(
//                     //     onPressed: verifyOTP(ref, context, enteredOTP),
//                     //     child: const Text(
//                     //       "Verify",
//                     //       style: TextStyle(
//                     //         fontSize: 18,
//                     //       ),
//                     //     ),
//                     //     style: ElevatedButton.styleFrom(
//                     //         backgroundColor: pinkLightColor[200],
//                     //         shape: RoundedRectangleBorder(
//                     //             borderRadius: BorderRadius.circular(14))),
//                     //   ),
//                     // ),
//                   ]),
//             )),
//           ),
//         ));
//   }
// }
