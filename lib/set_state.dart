library set_state;

///
/// Copyright (C) 2020 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  11 Dec 2020
///
///

import 'package:flutter/material.dart';

/// Create a subclass of the State class so to call the setState function
/// without a warning message.
/// Also to store this object in a static 'States' map.
abstract class SetState<T extends StatefulWidget> extends State<T>
    with StateSet {
  //
  SetState() : super() {
    // Stored this object in a static map
    _addToStates();
  }

  /// Return the specific Widget of type T
  @override
  T get widget => super.widget;

  /// Remove this object from the 'States' map.
  @override
  void dispose() {
    _removeFromStates();
    super.dispose();
  }

  /// Retrieve the SetState object by type
  /// Returns null if not found
  static SetState of<T extends SetState>() => StateSet.of<T>();

  /// Retrieve the first SetState object.
  static SetState get root => StateSet.root;

  /// Retrieve the latest context (i.e. the last State object's context)
  static BuildContext get lastContext => StateSet.lastContext;
}

mixin StateSet<T extends StatefulWidget> on State<T> {
  /// Called the State object's protected function.
  @override
  void setState(VoidCallback fn) => super.setState(fn);

  /// The static map of StateSet objects.
  static final Map<Type, StateSet> _setStates = {};

  /// Add this object to the static map
  void _addToStates() => _setStates.addAll({runtimeType: this});

  /// Remove this object from the static Map if not already removed.
  bool _removeFromStates() {
    // Sometimes a new State object was already created before
    // the old one was disposed.
    var remove = _setStates[runtimeType] == this;
    if (remove) {
      remove = _setStates.remove(runtimeType) != null;
    }
    return remove;
  }

  /// Retrieve the StateSet object by type
  /// Returns null if not found
  static StateSet of<T extends StateSet>() =>
      _setStates.isEmpty ? null : _setStates[_type<T>()];

  /// Retrieve the first StateSet object
  static StateSet get root =>
      _setStates.isEmpty ? null : _setStates.values.first;

  /// Retrieve the latest context (i.e. the last State object's context)
  static BuildContext get lastContext =>
      _setStates.isEmpty ? null : _setStates.values.last.context;

  /// Return the specified type from this function.
  static Type _type<T>() => T;
}

/// Implement so to serve as a Business Logic Component for a SetState object.
mixin StateBloc {
  /// The Subclass should supply the appropriate SetState object
  SetState state;

  /// Call your State object.
  void setState(fn) => state?.setState(fn);

  /// Nullify its reference in the State object's own dispose() function.
  /// Should clean up memory.
  @mustCallSuper
  void dispose() => state = null;
}
