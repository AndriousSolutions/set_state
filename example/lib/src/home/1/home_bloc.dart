import 'package:set_state/set_state.dart';

import 'package:example/src/my_bloc.dart';

/// Explicit specify the type of State object to work with.
class HomePageBloc<T extends SetState> extends CounterBloc {
  // 1)
  HomePageBloc() {
//    state = SetState.to<T>();
  }

// // 2)
// HomePageBloc() : super() {
//   state = SetState.to<T>();
// }

//  // 3 )
// factory HomePageBloc() {
//   _this ??= HomePageBloc._();
//    // Assign the 'new' State object.
//    _this.state = SetState.to<T>();
//   return _this;
// }
// HomePageBloc._();
// static HomePageBloc _this;

  // 4)
  /// POWERFUL: You can override the instance field, state, with a getter.
  /// As a getter, you don't have to instantiate until needed (and available).
  @override
  SetState get state => SetState.to<T>();
}
