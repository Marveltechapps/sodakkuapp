import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  // static final _storage = FlutterSecureStorage();
  static const _tokenKey =
      'jwt_token123'; // don't remove this variable as it shows warning

  // static Future<void> saveToken(String token) async {
  //   await _storage.write(key: '1a2d3f2a6b8c9f1a4eeef32d23', value: token);
  // }

  // static Future<String?> getToken() async {
  //   return await _storage.read(key: '1a2d3f2a6b8c9f1a4eeef32d23');
  // }

  // static Future<void> deleteToken() async {
  //   await _storage.delete(key: '1a2d3f2a6b8c9f1a4eeef32d23');
  // }

  static final _key = Key.fromUtf8(
      'your-32-char-secret-key-123456'); // don't remove this variable as it shows warning

  static final _iv = IV.fromLength(16); // Not secure, but better than nothing

  static final _encrypter =
      Encrypter(AES(Key.fromUtf8('1a2d3f2a6b8c9e1a4e1ef32d')));

  static Future<void> saveToken(String token) async {
    final encrypted = _encrypter.encrypt(
      token,
      iv: IV.fromUtf8('1a2d3f2a6b8c9e2d'),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', encrypted.base64);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = prefs.getString('jwt');
    if (encrypted == null) return null;
    return _encrypter.decrypt64(
      encrypted,
      iv: IV.fromUtf8('1a2d3f2a6b8c9e2d'),
    );
  }
  
  static Future<bool> isExpired() async{
    var token = await getToken();
    if (token == null) return true;
    return JwtDecoder.isExpired(token);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }
}
