
import 'package:set_state/set_state.dart';

import 'package:example/src/my_bloc.dart';

import 'package:example/src/2/second_page.dart';

//class SecondPageBloc<T extends SetState> extends _CounterBloc {
class SecondPageBloc extends CounterBloc {
  // // 1)
  // _SecondPageBloc() {
  //   state = SetState.of<T>();
  // }

  // // 2)
  // _SecondPageBloc() {
  //   state = SetState.of<_SecondPageState>();
  // }

  // 3 )
  // Retain the count even after its State is disposed!
  factory SecondPageBloc() {
    _this ??= SecondPageBloc._();
    // Assign the 'new' State object.
    _this.state = SetState.of<SecondPage>();
    return _this;
  }
  SecondPageBloc._();
  static SecondPageBloc _this;

//  // 4)
// /// POWERFUL: You can override the instance field with a getter.
// /// As a getter, you don't have to instantiate until needed (and available).
// @override
//  SetState get state => _state ??= SetState.of<T>();
// SetState _state;
}
