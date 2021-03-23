
import 'package:encrypt/encrypt.dart' as encrypt;

class ProcessData{
  static String getDecryptedData(String data){
    final key =
    encrypt.Key.fromBase64("nwRXfxsNX/R4dXBMLlX/u/CA2eYz7HBr2gfi8dRy12o=");

    final iv = encrypt.IV.fromBase64("4MyLqGZ8Sp6YeZMHc5ssbQ==");

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(data, iv: iv);
    return decrypted;
  }
  static String getEncryptedData(String data){

  }
}