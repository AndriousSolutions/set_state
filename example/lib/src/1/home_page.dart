
import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/1/home_bloc.dart';

import 'package:example/src/2/second_page.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : _state = _MyHomePageState(), super(key: key);
  final _MyHomePageState _state;

  @override
  _MyHomePageState createState() => _state;

  /// Supply a means to access its bloc
  void onPressed() => _state.onPressed();
}

/// The home page for this app.
class _MyHomePageState extends SetState<MyHomePage> {
  //
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
      title: const Text('Home Page'),
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
                  builder: (BuildContext context) => SecondPage()));
        },
      ),
    ],
  );
}

