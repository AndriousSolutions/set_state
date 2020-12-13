# set_state

A subclass of the State object placed in a static collection.

**Installing**

I don't always like the version number suggested in the '[Installing](https://pub.dev/packages/mvc_pattern#-installing-tab-)' page.
Instead, always go up to the '**major**' semantic version number when installing my library packages. This means always entering a version number trailing with two zero, '**.0.0**'. This allows you to take in any '**minor**' versions introducing new features as well as any '**patch**' versions that involves bugfixes. Semantic version numbers are always in this format: **major.minor.patch**.

1. **patch** - I've made bugfixes
2. **minor** - I've introduced new features
3. **major** - I've essentially made a new app. It's broken backwards-compatibility and has a completely new user experience. You won't get this version until you increment the **major** number in the pubspec.yaml file.

And so, add this to your pubspec.yaml file instead:
```javascript
dependencies:
  set_state:^1.0.0
```
For more information on this topic, read the article, [The importance of semantic versioning](https://medium.com/@xabaras/the-importance-of-semantic-versioning-9b78e8e59bba).

## Example App
Turn to the supplied example app to learn how to use this package.
[![exampleBlocs](https://user-images.githubusercontent.com/32497443/102015078-e843c200-3d1e-11eb-9a6f-722ad2aa3c22.jpg)](https://github.com/AndriousSolutions/set_state/blob/81ada0221dd8f921d2832f6782cdc5d94960d92e/example/lib/main.dart#L257)

## The Business side of the SetState object
Use the mixin, *StateBloc*, to readily access the underlying 'state object.' As you can see the class, _CounterBloc, below is the parent class of those above.
[![counterBloc](https://user-images.githubusercontent.com/32497443/102015308-6fde0080-3d20-11eb-8ace-47579dd30410.jpg)](https://github.com/AndriousSolutions/set_state/blob/81ada0221dd8f921d2832f6782cdc5d94960d92e/example/lib/main.dart#L286)
