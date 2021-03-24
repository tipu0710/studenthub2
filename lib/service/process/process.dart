import 'package:encrypt/encrypt.dart' as encrypt;

class ProcessData {
  static final _key =
      encrypt.Key.fromBase64("nwRXfxsNX/R4dXBMLlX/u/CA2eYz7HBr2gfi8dRy12o=");

  static final _iv = encrypt.IV.fromBase64("4MyLqGZ8Sp6YeZMHc5ssbQ==");

  static final _encrypter = encrypt.Encrypter(
      encrypt.AES(_key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

  static String getDecryptedData(String data) {
    final decrypted = _encrypter.decrypt64(data, iv: _iv);
    return decrypted;
  }

  static String getEncryptedData(String data) {
    var encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }
}
