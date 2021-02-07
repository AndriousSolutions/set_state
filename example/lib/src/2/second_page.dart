import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/1/home_page.dart';

import 'package:example/src/2/second_bloc.dart';

import 'package:example/src/3/third_page.dart';

/// The second page displayed in this app.
class SecondPage extends StatefulWidget {
  SecondPage({Key key})
      : _state = _SecondPageState(),
        super(key: key);
  final _SecondPageState _state;

  @override
  State createState() => _state;

  // Supply a means to access its bloc
  void onPressed() => _state.onPressed();
}

class _SecondPageState extends SetState<SecondPage> {
  _SecondPageState() : super() {
    bloc = SecondPageBloc();
  }
  SecondPageBloc bloc;
  MyHomePage home;

  @override
  void initState() {
    super.initState();
    home = MyHomePage();
  }

  @override
  void dispose() {
    // You should clean up after yourself.
    bloc.dispose();
    home = null;
    super.dispose();
  }

  // Supply a means to access its bloc
  void onPressed() => bloc.onPressed();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("You're on the Second Page"),
              const Text('You have pushed the button this many times:'),
              Text(
                '${bloc.data}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: bloc.onPressed,
          child: Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          RaisedButton(
            child: const Text('Home Page Counter'),
            onPressed: home?.onPressed,
          ),
          RaisedButton(
            child: const Text(
              'Home Page',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: const Text(
              'Third Page',
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ThirdPage()));
            },
          ),
        ],
      );
}
