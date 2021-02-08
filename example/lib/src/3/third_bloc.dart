import 'package:set_state/set_state.dart';

import 'package:example/src/3/third_page.dart';

import 'package:example/src/my_bloc.dart';

/// Retain a State object by knowing the type you're looking for.
class ThirdPageBloc extends CounterBloc {
  // // 1)
  // _ThirdPageBloc() {
  //   state = SetState.of<T>();
  // }

  // // 2)
  // _ThirdPageBloc() {
  //   state = SetState.of<_ThirdPageBloc>();
  // }

  //  // 3 )
  // factory _ThirdPageBloc() {
  //   _this ??= _ThirdPageBloc._();
  //   // Assign the 'new' State object.
  //   _this.state = SetState.of<_ThirdPageState>();
  //   return _this;
  // }
  // _ThirdPageBloc._();
  // static _ThirdPageBloc _this;

  // 4)
  /// POWERFUL: You can override the field with a getter.
  /// As a getter, you don't have to instantiate until needed (and available).
  @override
  SetState get state => _state ??= SetState.of<ThirdPage>();
  SetState _state;
}
