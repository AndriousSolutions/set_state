import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/home/2/second_screen.dart';

import 'package:example/src/app/menu/app_menu.dart';

class HomeScreen extends StatefulWidget {
  factory HomeScreen({Key key}) => _this ??= HomeScreen._(key: key);
  HomeScreen._({Key key}) : super(key: key);
  static HomeScreen _this;

  void onPressed() {
    // Don't use ??= to save on performance. The State object may be recreated.
    final _HomeScreenState state = SetState.to<_HomeScreenState>();
    state?.onPressed();
  }

  void newRoute() {
    // Don't use ??= to save on performance. The State object may be recreated.
    final _HomeScreenState state = SetState.to<_HomeScreenState>();
    state?.routeButton?.onPressed();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// The home page for this app.
class _HomeScreenState extends SetState<HomeScreen> {
  _HomeScreenState() : super();

  /// A mutable data field.
  int _counter = 0;

  /// Supply a means to access its bloc
  void onPressed() => _counter++;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen: Example App 01'),
          actions: [
            AppMenu(buttons: [routeButton]),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            onPressed();
          }),
          child: Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          routeButton,
        ],
      );

  RaisedButton get routeButton => RaisedButton(
        child: const Text(
          'Second Page',
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SecondScreen(),
            ),
          );
        },
      );
}
