import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../responsive.dart';
import 'widgets.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = 330.0;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: bottomSheetHeight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height:
                                (Responsive.isTablet(context)) ? 50.0 : 50.0,
                            width: (Responsive.isTablet(context)) ? 50.0 : 50.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
                                FirebaseAuth.instance.currentUser!.email![0]
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: (Responsive.isTablet(context))
                                        ? 35
                                        : 40.0,
                                    // color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.email!,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize:
                                    Responsive.isTablet(context) ? 20.0 : 18.0),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Language'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isTablet(context) ? 20.0 : 18.0),
                        ),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                        height: bottomSheetHeight,
                                        child: const ChangeLanguageWidget());
                                  });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isTablet(context) ? 20.0 : 18.0),
                        ),
                        const ThemeButton(),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Logout Successfully'.tr),
                                ),
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log Out'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isTablet(context) ? 20.0 : 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.currentUser!.delete().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('account deleted successfully'.tr),
                                ),
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Delete Account'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isTablet(context) ? 20.0 : 18.0,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        width: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        child: Center(
          child: Text(
            // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
            FirebaseAuth.instance.currentUser!.email![0].toUpperCase(),
            style: TextStyle(
                fontSize: (Responsive.isTablet(context)) ? 35 : 30.0,
                color: Colors.grey[200],
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// showDialog(
//   context: context,
//   builder: (context) {
//     return AlertDialog(
//       insetPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(
//             width: 10.0,
//           ),
//           const Text(
//             'Account',
//             style: TextStyle(fontWeight: FontWeight.w700),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(Icons.close),
//           ),
//         ],
//       ),
//       content: SizedBox(
//         width: Responsive.isTablet(context) ? 530 : 350.0,
//         height: Responsive.isTablet(context) ? 150.0 : 250.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   height: (Responsive.isTablet(context)) ? 50.0 : 32.0,
//                   width: (Responsive.isTablet(context)) ? 50.0 : 32.0,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(100.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
//                       FirebaseAuth.instance.currentUser!.email![0]
//                           .toUpperCase(),
//                       style: TextStyle(
//                           fontSize: (Responsive.isTablet(context))
//                               ? 35
//                               : 17.0,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//                 Text(
//                   FirebaseAuth.instance.currentUser!.email!,
//                   style: TextStyle(
//                       fontSize:
//                           Responsive.isTablet(context) ? 20.0 : 17.0),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 25.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Change language',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize:
//                           Responsive.isTablet(context) ? 20.0 : 18.0),
//                 ),
//                 GestureDetector(
//                     onTap: () {},
//                     child: const Icon(Icons.arrow_forward_ios, size: 20.0,)),
//               ],
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await googleSignIn.signOut();
//                 await FirebaseAuth.instance.signOut().then(
//                       (value) =>
//                           ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Berhasil logout'),
//                         ),
//                       ),
//                     );
//                 // ignore: use_build_context_synchronously
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Log Out',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize:
//                         Responsive.isTablet(context) ? 20.0 : 18.0),
//               ),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await FirebaseAuth.instance.currentUser!.delete().then(
//                       (value) =>
//                           ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('account deleted successfully'),
//                         ),
//                       ),
//                     );
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Delete Account',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize:
//                         Responsive.isTablet(context) ? 20.0 : 18.0,
//                     color: Colors.red),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );
