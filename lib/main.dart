import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:major_try/pages/hands_on_mode/tap_page/gridview_page.dart';
import 'package:major_try/pages/hands_on_mode/choose_option_page.dart';
import 'package:major_try/pages/hands_on_mode/tap_page/pronoun_page.dart';
import 'package:major_try/pages/home_page.dart';
import 'package:major_try/pages/hands_on_mode/typing_mode/typing_page.dart';
import 'package:major_try/themes.dart';
import 'package:major_try/utils/routes.dart';

import 'firebase_options.dart';
import 'pages/hands_on_mode/tap_page/noun_page.dart';
import 'pages/hands_on_mode/tap_page/verb_page.dart';
import 'pages/output_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamro Aawaj',
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.handsRoute: (context) => const HandsOn(),
        MyRoutes.typeRoute: (context) => const TypePage(),
        MyRoutes.pronounRoute: (context) => const PronounPage(),
      },
      home: const HomePage(),
    );
  }
}
