import 'dart:async';

import 'package:flutter/services.dart';

class UserDefaults {
  static const kDefaultKey = '[DEFAULT]';

  static const MethodChannel _channel =
      const MethodChannel('flutter.memspace.io/user_defaults');

  static final Map<String, UserDefaults> _instances = <String, UserDefaults>{};

  UserDefaults._(this.name);

  final String name;

  static UserDefaults getInstance([String key]) {
    key ??= kDefaultKey;
    if (_instances.containsKey(key)) return _instances[key];
    _instances[key] = new UserDefaults._(key);
    return _instances[key];
  }

  Future<dynamic> get(String key) async {
    final args = <String, dynamic>{'key': key, 'name': name};
    final Map<Object, Object> result = await _channel.invokeMethod('get', args);
    return result[key];
  }

  Future<bool> set(String key, dynamic value) async {
    final args = <String, dynamic>{'key': key, 'name': name, 'value': value};
    return await _channel
        .invokeMethod('set', args)
        .then<bool>((dynamic result) => result);
  }
}
