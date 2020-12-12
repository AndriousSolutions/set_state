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
    // Stored this object in a static 'States' map
    _addToStates();
  }

  /// Return the specific Widget of type T
  @override
  T get widget => super.widget;

  /// Retrieve an existing SetState by type.
  /// Note There can't be more than one of the same type.
  /// IMPORTANT to extend StateSet instead.
  // static SetState of<T extends SetState>() =>
  //     T == SetState && StateSet._setStates.isNotEmpty
  //         ? StateSet._setStates.values.last
  //         : StateSet.of<T>();
  static SetState of<T extends SetState>() =>
      StateSet._setStates.isEmpty ? null : StateSet.of<T>();

  /// The first State object
  static SetState get first => StateSet.first;

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// Remove this object from the 'States' map.
  @override
  void dispose() {
    _removeFromStates();
    super.dispose();
  }
}

mixin StateSet<T extends StatefulWidget> on State<T> {
  //
  @override
  void setState(VoidCallback fn) => super.setState(fn);

  void _addToStates() => _setStates.addAll({runtimeType: this});

  bool _removeFromStates() => _setStates.remove(runtimeType) != null;

  static final Map<Type, StateSet> _setStates = {};

  // If no type annotation specified, retrieve the last (most recent) State object.
  static StateSet of<T extends StateSet>() =>
      _setStates.isEmpty ? null : _setStates[_type<T>()];

  static StateSet get first =>
      _setStates.isEmpty ? null : _setStates.values.first;

  static Type _type<T>() => T;
}
