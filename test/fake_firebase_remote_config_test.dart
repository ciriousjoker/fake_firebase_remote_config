import 'package:flutter_test/flutter_test.dart';

import 'package:fake_firebase_remote_config/src/fake_firebase_remote_config_instance.dart';

void main() {
  test('Can store mocked values', () async {
    final config = FakeRemoteConfig();

    config.loadMockData({
      'some_bool': true,
      'some_int': 1337,
      'some_double': 69.42,
      'some_string': '👋',
    });

    await config.fetchAndActivate();

    expect(config.getBool("some_bool"), true);
    expect(config.getInt("some_int"), 1337);
    expect(config.getDouble("some_double"), 69.42);
    expect(config.getString("some_string"), "👋");
  });

  test('Provides default values on missing keys', () async {
    final config = FakeRemoteConfig();

    config.setDefaults({
      'some_default_bool': true,
      'some_default_int': 1337,
      'some_default_double': 69.42,
      'some_default_string': '👋',
    });

    // Defaults
    expect(config.getBool("some_default_bool"), true);
    expect(config.getInt("some_default_int"), 1337);
    expect(config.getDouble("some_default_double"), 69.42);
    expect(config.getString("some_default_string"), "👋");
  });
}
