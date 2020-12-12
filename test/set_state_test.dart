import 'package:flutter_test/flutter_test.dart';

import 'package:set_state/set_state.dart';

import '../example/lib/main.dart';

void main() {
  test('adds one to input values', () {
    final counter = MyApp();
    expect(counter.addOne(2), 3);
    expect(counter.addOne(-7), -6);
    expect(counter.addOne(0), 1);
    expect(() => counter.addOne(null), throwsNoSuchMethodError);
  });
}
