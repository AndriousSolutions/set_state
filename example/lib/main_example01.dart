import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

/// Demonstrates how to explicitly 're-create' a State object
class _MyAppState extends State<MyApp> with StateSet {
  /// Key identifies the widget. New key? New widget!
  Key _homeKey = UniqueKey();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(key: _homeKey),
      );

  @override
  void setState(VoidCallback fn) {
    _homeKey = UniqueKey();
    super.setState(fn);
  }
}

class MyHomePage extends StatefulWidget {
  //
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// The home page for this app.
class _MyHomePageState extends State<MyHomePage> with StateSet {
  //
  _MyHomePageState() : super() {
    bloc = _HomePageBloc<_MyHomePageState>();
  }
  _HomePageBloc bloc;

  @override
  void initState() {
    super.initState();

    /// Supply the State object to the BLoC
    bloc.initState();
  }

  @override
  void dispose() {
    // You should clean up after yourself.
    bloc.dispose();
    super.dispose();
  }

  /// Supply a means to access its bloc
  void onPressed() => bloc.onPressed();

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
          child: const Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const _SecondPage()));
            },
            child: const Text(
              'Second Page',
            ),
          ),
        ],
      );
}

/// The second page displayed in this app.
class _SecondPage extends StatefulWidget {
  //
  const _SecondPage({Key key}) : super(key: key);

  @override
  State createState() => _SecondPageState();
}

class _SecondPageState extends State<_SecondPage> with StateSet {
  // constructor
  _SecondPageState()
      : homeState = StateSet.to<_MyHomePageState>(),
        super();
  _SecondPageBloc bloc;
  _MyHomePageState homeState;

  @override
  void initState() {
    super.initState();

    /// Supply the State object to the BLoC
    bloc = _SecondPageBloc<_SecondPageState>();
  }

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
          child: const Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          RaisedButton(
            onPressed: homeState?.onPressed,
            child: const Text('Home Page Counter'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Home Page',
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const _ThirdPage()));
            },
            child: const Text(
              'Third Page',
            ),
          ),
        ],
      );
}

class _ThirdPage extends StatefulWidget {
  const _ThirdPage({Key key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

/// Demonstrates accessing the 'first' SetState object.
class _ThirdPageState extends State<_ThirdPage> with StateSet {
  _ThirdPageState()
      : secondState = StateSet.to<_SecondPageState>(),
        super() {
    // The corresponding Bloc
    bloc = _ThirdPageBloc<_ThirdPageState>();
    // Retrieve a specified State object.
    homeState = StateSet.to<_MyHomePageState>();
    // Retrieve the very 'first' State object!
    appState = StateSet.root;
  }
  _SecondPageState secondState;
  _ThirdPageBloc bloc;
  _MyHomePageState homeState;
  StateSet appState;

  @override
  void initState() {
    super.initState();

    /// Supply the State object to the BLoC
    bloc.initState();
  }

  @override
  void dispose() {
    // You should clean up after yourself.
    bloc.dispose();
    secondState = null;
    homeState = null;
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
          child: const Icon(Icons.add),
        ),
        persistentFooterButtons: <Widget>[
          RaisedButton(
            onPressed: homeState?.onPressed,
            child: const Text('Home Page Counter'),
          ),
          RaisedButton(
            onPressed: secondState?.onPressed,
            child: const Text('Second Page Counter'),
          ),
          RaisedButton(
            onPressed: () {
              appState?.setState(() {});
            },
            child: const Text('Home Page New Key'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text('Home Page'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Second Page'),
          ),
        ],
      );
}

/// Explicit specify the type of State object to work with.
class _HomePageBloc<T extends State> extends _CounterBloc<T> {
  /// Demonstrating how to extend the class, _CounterBloc
}

class _SecondPageBloc<T extends State> extends _CounterBloc<T> {
  // // Retain the count even after its State is disposed!
  // factory _SecondPageBloc() => _this ??= _SecondPageBloc._();
  // _SecondPageBloc._();
  // static _SecondPageBloc _this;
}

/// Retain a State object by knowing the type you're looking for.
class _ThirdPageBloc<T extends State> extends _CounterBloc<T> {
  /// POWERFUL: You can override the field with a getter.
  /// As a getter, you don't have to instantiate until needed (and available).
  @override
  T get state => StateSet.to<T>();
}

abstract class _CounterBloc<T extends State> extends StateBLoC<T> {
  /// The 'data' is a lone integer.
  int _counter = 0;

  /// Getter to safely access the data.
  int get data => _counter;

  /// The generic function (Flutter API) called to manipulate the data.
  void onPressed() => setState(() {
        _counter++;
      });
}
