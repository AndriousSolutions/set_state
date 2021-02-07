import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/1/home_page.dart';

import 'package:example/src/2/second_page.dart';

import 'package:example/src/3/third_bloc.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

/// Demonstrates accessing the 'first' SetState object.
class _ThirdPageState extends SetState<ThirdPage> {
  _ThirdPageState() : super();

  SecondPage second;
  ThirdPageBloc bloc;
  MyHomePage home;
  SetState appState;

  @override
  void initState() {
    super.initState();
    // The corresponding Bloc
    bloc = ThirdPageBloc();
    // Retrieve the very 'first' State object!
    appState = SetState.root;
    // Retrieve a specified State object.
    home = MyHomePage();
    second = SecondPage();
  }

  @override
  void dispose() {
    // You should clean up after yourself.
    second = null;
    home = null;
    super.dispose();
  }

  // Supply a means to externally access this State objects functionality.
  void onPressed() => bloc.onPressed();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("You're on the Third page."),
              const Text('You have pushed the button this many times:'),
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
            child: const Text('Home Page Counter'),
            onPressed: home?.onPressed,
          ),
          RaisedButton(
            child: const Text('Second Page Counter'),
            onPressed: second?.onPressed,
          ),
          RaisedButton(
            child: const Text('Home Page New Key'),
            onPressed: () {
              appState?.setState(() {});
            },
          ),
          RaisedButton(
            child: const Text('Home Page'),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          RaisedButton(
            child: const Text('Second Page'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
}
