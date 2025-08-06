import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class Util {
  static String formatWithOffset(DateTime dt) {
    final duration = dt.timeZoneOffset;
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final offset = '${duration.isNegative ? '-' : '+'}$hours:$minutes';
    final base = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dt);
    return '$base$offset';
  }

  static String privateKeySignature({
    required String clientId,
    required String timestamp,
    required String privateKeyPem,
  }) {
    // 1️⃣ StringToSign
    final stringToSign = '$clientId|$timestamp';

    // 2️⃣ Parse Private Key
    final privateKey = CryptoUtils.rsaPrivateKeyFromPem(privateKeyPem);

    // 3️⃣ Inisialisasi signer SHA256withRSA
    final signer = Signer('SHA-256/RSA');
    final privParams = PrivateKeyParameter<RSAPrivateKey>(privateKey);
    signer.init(true, privParams);

    // 4️⃣ Generate Signature
    final sig = signer.generateSignature(
      Uint8List.fromList(utf8.encode(stringToSign)),
    ) as RSASignature;

    // 5️⃣ Encode Base64
    return base64Encode(sig.bytes);
  }

  static String secretKeySignature({
    required String httpMethod,
    required String endpoint,
    required String token,
    required String timestamp,
    required String body,
    required String clientSecret,
  }) {
    // 1️⃣ Hash request body dengan SHA-256 → hex lowercase
    final bodyHash = sha256.convert(utf8.encode(body)).bytes;
    final hexEncodeBody =
        bodyHash.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    // 2️⃣ Build stringToSign pakai colon
    final stringToSign =
        '$httpMethod:$endpoint:$token:$hexEncodeBody:$timestamp';

    // 3️⃣ Generate HMAC-SHA512
    final key = utf8.encode(clientSecret);
    final message = utf8.encode(stringToSign);
    final hmacSha512 = Hmac(sha512, key);
    final digest = hmacSha512.convert(message);

    // 4️⃣ Base64 encode
    return base64Encode(digest.bytes);
  }
}
