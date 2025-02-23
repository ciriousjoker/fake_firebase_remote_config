# Fake Firebase Remote Config

[![pub package](https://img.shields.io/pub/v/fake_firebase_remote_config.svg)](https://pub.dartlang.org/packages/fake_firebase_remote_config)

Fakes to write unit tests for Firebase Remote Config. Instantiate a `FakeRemoteConfig`, then pass it around your project to replace `RemoteConfig.instance`. This fake acts like `RemoteConfig` except it will load mocked data instead.

## Usage

### A simple usage example

```dart
import 'package:fake_firebase_remote_config/fake_firebase_remote_config.dart';

void main() async {
  final config = FakeRemoteConfig();
  await config.setDefaults({
    // ...
  });

  config.loadMockData({
    // ...
  });

  await config.fetchAndActivate();
}
```

This `config` object needs to replace the real `RemoteConfig.instance` during testing. You can do this for example with [Riverpod](https://pub.dev/packages/riverpod) or by doing something like this:

```dart
await tester.pumpWidget(
  MaterialApp(
    title: 'RemoteConfig Example',
    home: MyApp(overrideRemoteConfig: config),
  ),
);
```

## Missing functionality

- `config.app` will throw
- `config.pluginConstants` will throw
- `config.getValue(String key)` will throw if the key is missing
- Everything related to `config.settings` serve no purpose. Data is loaded manually.

## Compatibility table

| firebase_remote_config | fake_firebase_remote_config |
| ---------------------- | --------------------------- |
| >=0.9.0-dev.0 <4.0.0   | 1.0.x                       |
| >=4.0.0 <5.0.0         | 2.0.x                       |
| >=4.0.0 <5.4.0         | 2.1.x                       |
| >=4.0.0 current        | 2.2.x                       |

Last updated for `firebase_remote_config: 5.4.1`.

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/CiriousJoker/fake_firebase_remote_config/issues).
