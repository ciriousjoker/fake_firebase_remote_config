library fake_firebase_remote_config;

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/foundation.dart';

/// Fake implementation of [FirebaseRemoteConfig] for testing.
class FakeRemoteConfig with ChangeNotifier implements FirebaseRemoteConfig {
  final _mocked = <String, RemoteConfigValue>{};
  var _data = <String, RemoteConfigValue>{};
  final _defaults = <String, RemoteConfigValue>{};

  @override
  Future<bool> activate() {
    _data = _mocked;
    return Future.value(true);
  }

  @override
  FirebaseApp get app => throw UnimplementedError();

  @override
  Future<void> ensureInitialized() {
    return Future.value();
  }

  @override
  Future<void> fetch() {
    lastFetchTime = DateTime.now();
    return Future.value();
  }

  @override
  Future<bool> fetchAndActivate() async {
    await fetch();
    return activate();
  }

  @override
  Map<String, RemoteConfigValue> getAll() {
    return _data;
  }

  @override
  bool getBool(String key) {
    return _data[key]?.asBool() ??
        _defaults[key]?.asBool() ??
        RemoteConfigValue.defaultValueForBool;
  }

  @override
  double getDouble(String key) {
    return _data[key]?.asDouble() ??
        _defaults[key]?.asDouble() ??
        RemoteConfigValue.defaultValueForDouble;
  }

  @override
  int getInt(String key) {
    return _data[key]?.asInt() ??
        _defaults[key]?.asInt() ??
        RemoteConfigValue.defaultValueForInt;
  }

  @override
  String getString(String key) {
    return _data[key]?.asString() ??
        _defaults[key]?.asString() ??
        RemoteConfigValue.defaultValueForString;
  }

  @override
  RemoteConfigValue getValue(String key) {
    return _data[key] ?? _defaults[key]!;
  }

  @override
  RemoteConfigFetchStatus get lastFetchStatus =>
      RemoteConfigFetchStatus.success;

  @override
  DateTime lastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Map get pluginConstants => throw UnimplementedError();

  @override
  Future<void> setConfigSettings(RemoteConfigSettings remoteConfigSettings) {
    settings = remoteConfigSettings;
    return Future.value();
  }

  @override
  Future<void> setDefaults(Map<String, dynamic> defaultParameters) {
    defaultParameters.forEach((key, value) {
      _defaults[key] = RemoteConfigValue(
        const Utf8Encoder().convert(value.toString()),
        ValueSource.valueDefault,
      );
    });
    return Future.value();
  }

  /// Load mocked data into the [FakeRemoteConfig].
  /// You still need to call [fetchAndActivate] to activate the data.
  void loadMockData(Map<String, dynamic> data) {
    data.forEach((key, value) {
      _mocked[key] = RemoteConfigValue(
        const Utf8Encoder().convert(value.toString()),
        ValueSource.valueRemote,
      );
    });
  }

  @override
  RemoteConfigSettings settings = RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 2),
    minimumFetchInterval: const Duration(seconds: 2),
  );
}
