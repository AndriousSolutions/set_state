
import 'package:set_state/set_state.dart';

/// Made abstract to 'remind the developer' to supply a SetState object.
abstract class CounterBloc with StateBloc {
  /// The 'data' is a lone integer.
  int _counter = 0;

  /// Getter to safely access the data.
  int get data => _counter;

  /// The generic function (Flutter API) called to manipulate the data.
  void onPressed() => setState(() {
    _counter++;
  });
}