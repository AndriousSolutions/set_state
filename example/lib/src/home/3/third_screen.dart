import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/home/1/home_screen.dart';

import 'package:example/src/home/2/second_screen.dart';

import 'package:example/src/app/menu/app_menu.dart';


class ThirdScreen extends StatefulWidget {
  factory ThirdScreen({Key key}) => _this ??= ThirdScreen._(key: key);
  ThirdScreen._({Key key}) : super(key: key);
  static ThirdScreen _this;

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends SetState<ThirdScreen> {
  _ThirdScreenState() : super();

  /// A mutable data field.
  int _counter = 0;

  void onPressed() {
    _counter++;
    setState(() {});
  }

  /// Raised buttons used in the popmenu and the screen itself.
  final List<RaisedButton> buttons = [];

  @override
  void initState() {
    super.initState();
    buttons.addAll([
      homeScreenCounter,
      secondScreenCounter,
      resetHome,
      homeScreen,
      secondScreen,
    ]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Third Screen'),
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
          onPressed: onPressed,
          child: Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              homeScreenCounter,
              secondScreenCounter,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              resetHome,
              homeScreen,
              secondScreen,
            ],
          ),
        ],
      );

  RaisedButton get homeScreenCounter => RaisedButton(
        child: const Text('Home Counter'),
        onPressed: () {
          final HomeScreen home = HomeScreen();
          home?.onPressed();
          final State state = SetState.of<HomeScreen>();
          state?.setState(() {});
        },
      );

  RaisedButton get secondScreenCounter => RaisedButton(
        child: const Text('Second Counter'),
        onPressed: () {
          final second = SecondScreen();
          second?.onPressed();
          final state = SetState.of<SecondScreen>();
          state?.setState(() {});
        },
      );

  RaisedButton get resetHome => RaisedButton(
        child: const Text('Reset Home'),
        onPressed: () {
          final State appState = SetState.root;
          appState?.setState(() {});
        },
      );

  RaisedButton get homeScreen => RaisedButton(
        child: const Text('Home Screen'),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      );

  RaisedButton get secondScreen => RaisedButton(
        child: const Text('Second Screen'),
        onPressed: () {
          Navigator.pop(context);
        },
      );
}
