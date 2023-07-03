// // import 'package:example/main.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:nutria/main.dart';
// import 'package:patrol/patrol.dart';
//
// // export 'package:example/main.dart';
// export 'package:flutter_test/flutter_test.dart';
// export 'package:patrol/patrol.dart';
//
// const _patrolTesterConfig = PatrolTesterConfig();
// const _nativeAutomatorConfig = NativeAutomatorConfig(
//   findTimeout: Duration(seconds: 20), // 10 seconds is too short for some CIs
// );
//
// Future<void> createApp(PatrolTester $) async {
//   await $.pumpWidget(const MyApp());
// }
//
// void patrol(
//   String description,
//   Future<void> Function(PatrolTester) callback, {
//   bool? skip,
// }) {
//   patrolTest(
//     description,
//     config: _patrolTesterConfig,
//     nativeAutomatorConfig: _nativeAutomatorConfig,
//     nativeAutomation: true,
//     skip: skip,
//     callback,
//   );
// }
