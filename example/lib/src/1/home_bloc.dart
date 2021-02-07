
import 'package:set_state/set_state.dart';

import 'package:example/src/my_bloc.dart';

/// Explicit specify the type of State object to work with.
class HomePageBloc<T extends SetState> extends CounterBloc {
  // 1)
  HomePageBloc() {
    state = SetState.to<T>();
  }

// // 2)
// _HomePageBloc() : super() {
//   state = SetState.of<_HomePageBloc>();
// }

//  // 3 )
// factory _HomePageBloc() {
//   _this ??= _HomePageBloc._();
//   // Assign the 'new' State object.
//   _this.state = SetState.of<T>();
//   return _this;
// }
// _HomePageBloc._();
// static _HomePageBloc _this;

//  // 4)
// /// POWERFUL: You can override the instance field with a getter.
// /// As a getter, you don't have to instantiate until needed (and available).
// @override
//  SetState get state {
//   if(_state == null){
//      _state ??= SetState.of<T>();
//   }
//   return _state;
//   }
// SetState _state;
}