import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

import 'package:example/src/1/home_page.dart';

import 'package:example/src/2/second_bloc.dart';
import 'package:example/src/my_bloc.dart';

import 'package:example/src/3/third_page.dart';

/// The second page displayed in this app.
class SecondPage extends StatefulWidget {
  factory SecondPage({Key key}) => _this ??= SecondPage._(key: key);
  SecondPage._({Key key}) : super(key: key);
  static SecondPage _this;

  @override
  State createState() => _SecondPageState();

  // Supply a means to access its bloc
  void onPressed() {
    final _SecondPageState state = SetState.to<_SecondPageState>();
    state.onPressed();
  }
}

class _SecondPageState extends SetState<SecondPage> {
  _SecondPageState() : super() {
    /// This 'local' can use the factory constructor but not in a  separate Dart file??
    // bloc = LocalSecondPageBloc<_SecondPageState>();
    bloc = SecondPageBloc<_SecondPageState>();
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

/// This seems to reliably works every time.
class LocalSecondPageBloc extends CounterBloc {
  // // 1)
  // LocalSecondPageBloc() {
  //   state = SetState.to<T>();
  // }

  // // 2)
  // // With a factory, retains the count even after its State is disposed!
  // factory LocalSecondPageBloc() => _this ??= SecondPageBloc._();
  // LocalSecondPageBloc._();
  // static LocalSecondPageBloc _this;

  // 3 )
  // Retain the count even after its State is disposed!
  factory LocalSecondPageBloc() {
    _this ??= LocalSecondPageBloc._();
    // Assign the 'new' State object.
    _this.state = SetState.to<_SecondPageState>();
    return _this;
  }
  LocalSecondPageBloc._();
  static LocalSecondPageBloc _this;

//  // 4)
// /// POWERFUL: You can override the instance field with a getter.
// /// As a getter, you don't have to instantiate until needed (and available).
//   @override
//   SetState get state => _state ??= SetState.to<T>();
//   SetState _state;
}
