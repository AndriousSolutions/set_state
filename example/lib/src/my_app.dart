import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/1/home_page.dart';

class MyApp extends StatefulWidget {
  //
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

/// Demonstrates how to explicitly 're-create' a State object
class _MyAppState extends SetState<MyApp> {
  /// Key identifies the widget. New key? New widget!
  Key _homeKey = UniqueKey();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(key: _homeKey),
      );

  void setState(VoidCallback fn) {
    _homeKey = UniqueKey();
    super.setState(fn);
  }
}
