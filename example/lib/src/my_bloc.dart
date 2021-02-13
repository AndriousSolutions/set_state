import 'package:flutter/material.dart';

import 'package:set_state/set_state.dart';

/// Made abstract to 'remind the developer' to supply a SetState object.
class CounterBloc<T extends State> extends StateBLoC<T> {
  /// The 'data' is a lone integer.
  int _counter = 0;

  /// Getter to safely access the data.
  int get data => _counter;

  /// The generic function (Flutter API) called to manipulate the data.
  void onPressed() => setState(() {
        _counter++;
      });
}
