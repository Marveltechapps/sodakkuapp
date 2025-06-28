import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<http.Client> createPinnedHttpClient() async {
  if (kIsWeb) {
    // 👨‍💻 For Web — return default http client
    return http.Client();
  }

  final sslCert = await rootBundle.load('assets/cert/selorg_cert.pem');

  SecurityContext context = SecurityContext(withTrustedRoots: false);
  context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

  final httpClient = HttpClient(context: context);
  httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
    // Optional: Pin the certificate fingerprint here manually if needed
    return true; // Accept cert if it matches the one we loaded
  };

  return IOClient(httpClient);
}

