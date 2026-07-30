import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/entities/session_entity.dart';
import '../models/entities/token_entity.dart';

class SecureStorageHelper {
  SecureStorageHelper._(this._storage);

  static const _tokenKey = 'api_token';
  static const _sessionKey = 'api_session';

  static final instance = SecureStorageHelper._(
    const FlutterSecureStorage(),
  );

  final FlutterSecureStorage _storage;

  Future<void> saveToken(TokenEntity token) {
    return _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  Future<TokenEntity?> getToken() async {
    final encoded = await _storage.read(key: _tokenKey);
    if (encoded == null) return null;
    try {
      return TokenEntity.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
    } on FormatException {
      return null;
    }
  }

  Future<void> saveSession(SessionEntity session) {
    return _storage.write(
      key: _sessionKey,
      value: jsonEncode(session.toJson()),
    );
  }

  Future<SessionEntity?> getSession() async {
    final encoded = await _storage.read(key: _sessionKey);
    if (encoded == null) return null;
    try {
      return SessionEntity.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
    } on FormatException {
      return null;
    }
  }

  Future<void> clearAuth() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _sessionKey);
  }
}
