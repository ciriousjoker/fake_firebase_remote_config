import 'dart:math';

import 'package:fake_firebase_remote_config/fake_firebase_remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

void main() {
  final useMocks = Random().nextBool();
  final remoteConfig = useMocks ? FakeRemoteConfig() : FirebaseRemoteConfig.instance;
  remoteConfig.fetchAndActivate();

  runApp(Container());
}
