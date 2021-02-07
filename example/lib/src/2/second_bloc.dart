
import 'package:set_state/set_state.dart';

import 'package:example/src/my_bloc.dart';

/// a static counter is necessary to retain the count
/// because <T extends SetState> does work with factory constructor
class SecondPageBloc<T extends SetState> with StateBloc { // extends CounterBloc {
  // 1)
  SecondPageBloc() {
    state = SetState.to<T>();
  }

  /// The 'data' is a lone integer.
  static int _counter = 0;

  /// Getter to safely access the data.
  int get data => _counter;

  /// The generic function (Flutter API) called to manipulate the data.
  void onPressed() => setState(() {
    _counter++;
  });

  /// For a factory constructor to work, this class same Dart file as _SecondPageState.
  // // 2)
  // // With a factory, retains the count even after its State is disposed!
  // factory SecondPageBloc() => _this ??= SecondPageBloc._();
  // SecondPageBloc._();
  // static SecondPageBloc _this;

/// For a factory constructor to work, this class same Dart file as _SecondPageState.
  // // 3 )
  // Retain the count even after its State is disposed!
  // factory SecondPageBloc() {
  //   _this ??= SecondPageBloc._();
  //   // Assign the 'new' State object.
  //   _this.state = SetState.to<T>();
  //   return _this;
  // }
  // SecondPageBloc._();
  // static SecondPageBloc _this;


/// POWERFUL: You can override the instance field with a getter.
/// As a getter, you don't have to instantiate until needed (and available).
//   // 4)
//   @override
//   SetState get state => _state ??= SetState.to<T>();
//   SetState _state;
}



