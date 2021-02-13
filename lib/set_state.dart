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

// /// Create a subclass of the State class so to call the setState function
// /// without a warning message.
// /// Also to store this object in a static 'States' map.
// abstract class SetState<T extends StatefulWidget> extends State<T>
//     with StateSet {
//   // If no declared constructor, a default constructor is called.
//   // It has no arguments and invokes the superclass's no-argument constructor.
//
//   /// Retrieve the SetState object by its StatefulWidget's type
//   /// Returns null if not found
//   static SetState of<T extends StatefulWidget>() => StateSet.of<T>();
//
//   /// Retrieve the SetState object by type
//   /// Returns null if not found
//   static SetState to<T extends SetState>() => StateSet.to<T>();
//
//   /// Retrieve the first SetState object.
//   static SetState get root => StateSet.root;
//
//   /// Retrieve the latest context (i.e. the last State object's context)
//   static BuildContext get lastContext => StateSet.lastContext;
// }

/// Manages the collection of State objects extended by the SetState class
mixin StateSet<T extends StatefulWidget> on State<T> {
  /// The static map of StateSet objects.
  static final Map<Type, State> _setStates = {};

  /// The static map of StatefulWidget objects.
  static final Map<Type, Type> _stateWidgets = {};

  /// Adds State object to a static map
  /// Adds StatefulWidget to a static map
  /// add this function to the State object's initState() function.
  @override
  void initState() {
    super.initState();
    _setStates.addAll({runtimeType: this});
    if (widget != null) {
      _stateWidgets.addAll({widget.runtimeType: runtimeType});
    }
  }

  /// Remove objects from the static Maps if not already removed.
  /// add this function to the State object's dispose function instead
  @override
  void dispose() {
    // Sometimes a new State object was already created before
    // the old one was disposed.
    var remove = _setStates[runtimeType] == this;
    if (remove) {
      final state = _setStates.remove(runtimeType);
      remove = state != null;
      if (remove) {
        _stateWidgets.remove(state.widget?.runtimeType);
      }
    }
    super.dispose();
  }

  /// Retrieve the State object by its StatefulWidget
  /// Returns null if not found
  static State of<T extends StatefulWidget>() {
    final stateType = _stateWidgets.isEmpty ? null : _stateWidgets[_type<T>()];
    return _stateWidgets.isEmpty ? null : _setStates[stateType];
  }

  /// Retrieve the State object by type
  /// Returns null if not found
  static State to<T extends State>() =>
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
class StateBLoC<T extends State> {
  StateBLoC() {
    // Note, this is in case State object is available at this time.
    state = StateSet.to<T>();
  }

  /// The Subclass should supply the appropriate SetState object
  T state;

  /// Not necessary. May lead to confusion
  // /// Explicitly assign a State object but only if 'state' is null
  // bool assignState() {
  //   var assigned = state == null;
  //   if (assigned) {
  //     state = StateSet.to<T>();
  //     assigned = state != null;
  //   }
  //   return assigned;
  // }

  /// Call your State object.
  // ignore: invalid_use_of_protected_member
  void setState(VoidCallback fn) => state?.setState(fn);

  /// Supply the State object to this BloC object.
  @mustCallSuper
  void initState() {
    state = StateSet.to<T>();
  }

  /// Nullify its reference in the State object's own dispose() function.
  /// Should clean up memory.
  @mustCallSuper
  void dispose() {
    state = null;
  }
}
