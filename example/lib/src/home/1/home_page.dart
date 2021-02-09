import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/app/menu/app_menu.dart';

import 'package:example/src/home/1/home_bloc.dart';

import 'package:example/src/home/2/second_page.dart';

class MyHomePage extends StatefulWidget {
  factory MyHomePage({Key key}) => _this ??= MyHomePage._(key: key);
  MyHomePage._({Key key}) : super(key: key);
  static MyHomePage _this;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  // Supply a means to access its bloc
  void onPressed() {
    final _MyHomePageState state = SetState.to<_MyHomePageState>();
    state.onPressed();
  }
}

/// The home page for this app.
class _MyHomePageState extends SetState<MyHomePage> {
  _MyHomePageState() : super() {
    bloc = HomePageBloc<_MyHomePageState>();
  }
  HomePageBloc bloc;

  /// Supply a means to access its bloc
  void onPressed() => bloc.onPressed();

  @override
  void dispose() {
    // You should clean up after yourself.
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page: Example App 02'),
          actions: [
            AppMenu(),
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
                '${bloc.data}',
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
          RaisedButton(
            child: const Text(
              'Second Page',
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SecondPage(),
                ),
              );
            },
          ),
        ],
      );
}
