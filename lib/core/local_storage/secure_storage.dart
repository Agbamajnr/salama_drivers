import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/auth/person_model.dart';

abstract class SecureStorage {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<PersonModel?> getUser();
  Future<void> saveUser(PersonModel user);
  Future<void> clearUser();
}

@LazySingleton(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl(this.storage);

  final FlutterSecureStorage storage;
  @override
  Future<void> clearUser() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> getToken() async {
    return storage.read(key: accessTokenKey);
  }

  @override
  Future<void> saveToken(String token) {
    return storage.write(key: accessTokenKey, value: token);
  }

  @override
  Future<PersonModel?> getUser() async {
    try {
      var data = await storage.read(key: userKey);
      return data != null ? PersonModel.fromJson(jsonDecode(data)) : null;
    } catch (e) {}
    return null;
  }

  @override
  Future<void> saveUser(PersonModel user) {
    return storage.write(
      key: userKey,
      value: json.encode(user.toJson()),
    );
  }
}

const String accessTokenKey = 'token';
const String userKey = 'user';
