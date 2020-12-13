import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

/// High-level variable. Identifies the widget. New key? New widget!
Key _homeKey = UniqueKey();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

/// Demonstrates how to explicitly 're-create' a State object
class _MyAppState extends SetState<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(key: _homeKey),
      );
}

class MyHomePage extends StatefulWidget {
  //
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// The home page for this app.
class _MyHomePageState extends SetState<MyHomePage> {
  //
  _MyHomePageState() : super() {
    bloc = _HomePageBloc<_MyHomePageState>();
  }
  _HomePageBloc bloc;

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
                      builder: (BuildContext context) => _SecondPage()));
            },
          ),
        ],
      );
}

/// The second page displayed in this app.
class _SecondPage extends StatefulWidget {
  //
  _SecondPage({Key key}) : super(key: key);

  @override
  State createState() => _SecondPageState();
}

class _SecondPageState extends SetState<_SecondPage> {
  // constructor
  _SecondPageState()
      : homeState = SetState.of<_MyHomePageState>(),
        super() {
    bloc = _SecondPageBloc();
  }
  _SecondPageBloc bloc;
  _MyHomePageState homeState;

  @override
  void dispose() {
    // You should clean up after yourself.
    bloc.dispose();
    homeState = null;
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
            onPressed: homeState?.onPressed,
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
                      builder: (BuildContext context) => _ThirdPage()));
            },
          ),
        ],
      );
}

class _ThirdPage extends StatefulWidget {
  _ThirdPage({Key key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

/// Demonstrates accessing the 'first' SetState object.
class _ThirdPageState extends SetState<_ThirdPage> {
  _ThirdPageState()
      : secondState = SetState.of<_SecondPageState>(),
        super() {
    bloc = _ThirdPageBloc();
    // Retrieve a specified State object.
    homeState = SetState.of<_MyHomePageState>();
    // Retrieve the very 'first' State object!
    appState = SetState.root;
  }
  _SecondPageState secondState;
  _ThirdPageBloc bloc;
  _MyHomePageState homeState;
  State appState;

  @override
  void dispose() {
    // You should clean up after yourself.
    secondState = null;
    bloc.dispose();
    homeState = null;
    super.dispose();
  }

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
          onPressed: bloc.onPressed,
          child: Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          RaisedButton(
            child: const Text('Home Page Counter'),
            onPressed: homeState?.onPressed,
          ),
          RaisedButton(
            child: const Text('Second Page Counter'),
            onPressed: secondState?.onPressed,
          ),
          RaisedButton(
            child: const Text('Home Page New Key'),
            onPressed: () {
              appState?.setState(() {
                _homeKey = UniqueKey();
              });
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

/// Explicit specify the type of State object to work with.
class _HomePageBloc<T extends SetState> extends _CounterBloc {
  _HomePageBloc() : super() {
    state = SetState.of<T>();
  }
}

/// Retain a State object by knowing the type you're looking for.
class _SecondPageBloc extends _CounterBloc {
  _SecondPageBloc() : super() {
    state = SetState.of<_SecondPageState>();
  }
}

/// Re-assign a possibly 'new' State object.
/// The previous one may have been disposed.
/// Note the factory constructor always the 'data' to be retained.
class _ThirdPageBloc extends _CounterBloc {
  // Retain the count even after dispose!
  factory _ThirdPageBloc() {
    _this ??= _ThirdPageBloc._();
    // Assign the 'new' third State object.
    _this.state = SetState.of<_ThirdPageState>();
    return _this;
  }
  _ThirdPageBloc._();
  static _ThirdPageBloc _this;
}

/// Made abstract to 'remind the developer' to supply a SetState object.
abstract class _CounterBloc with StateBloc {
  _CounterBloc();

  int _counter = 0;

  /// Getter to safely access the data.
  int get data => _counter;

  /// The generic function (Flutter API) called to manipulate the data.
  void onPressed() => setState(() {
        _counter++;
      });
}
