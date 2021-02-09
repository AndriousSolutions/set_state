import 'package:set_state/set_state.dart';

import 'package:example/src/home/3/third_page.dart';

import 'package:example/src/my_bloc.dart';

/// Retain a State object by knowing the type you're looking for.
// class ThirdPageBloc<T extends SetState> extends CounterBloc {
class ThirdPageBloc extends CounterBloc {
  // // 1)
  // ThirdPageBloc() {
  //   state = SetState.of<T>();
  // }

  // // 2)
  // ThirdPageBloc() {
  //   state = SetState.of_ThirdPageBloc>();
  // }

  //  // 3 )
  // factory ThirdPageBloc() {
  //   _this ??= ThirdPageBloc._();
  //   // Assign the 'new' State object.
  //   _this.state = SetState.to<ThirdPageState>();
  //   return _this;
  // }
  // _ThirdPageBloc._();
  // static _ThirdPageBloc _this;

  // 4)
  /// POWERFUL: You can override the field, state, with a getter.
  /// As a getter, you don't have to instantiate until needed (and available).
  @override
  SetState get state => SetState.of<ThirdPage>();
}
