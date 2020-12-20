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
    with BlocState, StateSet {
  //
  SetState([StateBloc bloc]) : super() {
    addBloc(bloc);
    // Stored this object in a static map
    _addToStates();
  }

  /// Return the specific Widget of type T
  @override
  T get widget => super.widget;

  /// Remove this object from the 'States' map.
  @override
  void dispose() {
    clearBlocs();
    _removeFromStates();
    super.dispose();
  }

  /// Retrieve the SetState object by type
  /// Returns null if not found
  static SetState of<T extends SetState>() => StateSet.of<T>();

  /// Retrieve the first SetState object.
  static SetState get root => StateSet.root;
}

mixin StateSet<T extends StatefulWidget> on State<T> {
  /// Called the Stat object's protected function.
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

/// State object introduces a Bloc instance field
mixin BlocState {
  /// The map of bloc objects.
  final Map<Type, StateBloc> _blocs = {};

  Iterable<MapEntry<Type, StateBloc>> get entries => _blocs.entries;

  Iterator get iterator => entries.iterator;

  int get length => _blocs.length;

  bool get isEmpty => _blocs.isEmpty;

  bool get isNotEmpty => !isEmpty;

  /// The first Bloc in the collection.
  MapEntry<Type, StateBloc> get first {
    if (entries.isEmpty) {
      return null;
    }
    return entries.first;
  }

  /// The most recent Bloc added to the collection.
  MapEntry<Type, StateBloc> get last {
    if (entries.isEmpty) {
      return null;
    }
    return entries.last;
  }

  /// Supply the corresponding 'Bloc' counterpart.
  StateBloc get bloc {
    final element = first;
    if (element == null) {
      return null;
    }
    return element.value;
  }

  /// Retrieve the StateSet object by type
  /// Returns null if not found
  StateBloc blocOf<T extends StateBloc>() =>
      _blocs.isEmpty ? null : _blocs[_type<T>()];

  /// Return the specified type from this function.
  Type _type<T>() => T;

  /// Add this object to the static map
  void addBloc(StateBloc bloc) {
    if (bloc != null) {
      _blocs.addAll({bloc.runtimeType: bloc});
    }
  }

  /// Remove this object from the static Map if not already removed.
  bool removeBloc(StateBloc bloc) => _blocs.remove(bloc.runtimeType) != null;

  /// Remove this object from the 'Blocs' map.
  void clearBlocs() => _blocs.clear();

  void disposeBlocs() {
    entries.forEach((map) {
      map.value.dispose();
    });
  }
}
