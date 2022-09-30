import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/screen/login.dart';
import 'package:instagram_clone/screen/sign_up_form.dart';
import 'package:instagram_clone/screen/sign_up_methods.dart';
import 'package:instagram_clone/screen/sign_up_options.dart';
import 'package:instagram_clone/screen/starting_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Start(),
      locale: _locale,
    );
  }
}

class Start extends StatefulWidget {

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  void initState() {
    Timer(Duration(seconds: 3), openStartingUpPage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          SvgPicture.asset(
            'assets/images/insta_icon.svg',
            height: 160.0,
            width: 160.0,
        ),
      ),
    );
  }
  void openStartingUpPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StartingUp()));
  }
}
