
import 'package:account_manager/navigator/navigator_bar.dart';
import 'package:account_manager/screens/authenticate/sign_in.dart';
import 'package:account_manager/services/auth.dart';
import 'package:account_manager/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Wrapper(),
    );
  }
}
