import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/home/1/home_screen.dart';

import 'package:example/src/home/3/third_screen.dart';

import 'package:example/src/app/menu/app_menu.dart';

/// The second page displayed in this app.
class SecondScreen extends StatefulWidget {
  factory SecondScreen({Key key}) => _this ??= SecondScreen._(key: key);
  SecondScreen._({Key key}) : super(key: key);
  static SecondScreen _this;

  void onPressed() {
    final _SecondPageState state = SetState.to<_SecondPageState>();
    state.onPressed();
  }

  @override
  State createState() => _SecondPageState();
}

class _SecondPageState extends SetState<SecondScreen> {
  _SecondPageState() : super();

  /// A mutable data field.
  int _counter = 0;

  /// Supply a means to access its bloc
  void onPressed() => _counter++;

  /// Raised buttons used in the popmenu and the screen itself.
  final List<RaisedButton> buttons = [];

  @override
  void initState() {
    super.initState();
    buttons.addAll([homeScreenCounter, homeScreen, thirdScreen]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Screen'),
          actions: [
            AppMenu(buttons: buttons),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(onPressed),
          child: Icon(Icons.add),
        ),
        persistentFooterButtons: buttons,
      );

  RaisedButton get homeScreenCounter => RaisedButton(
        child: const Text(
          'Home Counter',
        ),
        onPressed: () {
          final HomeScreen home = HomeScreen();
          home?.onPressed();
          final State state = SetState.of<HomeScreen>();
          state?.setState(() {});
        },
      );

  RaisedButton get homeScreen => RaisedButton(
        child: const Text(
          'Home Screen',
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );

  RaisedButton get thirdScreen => RaisedButton(
        child: const Text(
          'Third Screen',
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ThirdScreen()));
        },
      );
}
