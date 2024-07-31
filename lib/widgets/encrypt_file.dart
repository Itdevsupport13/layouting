import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncryptFile extends StatefulWidget {
  const EncryptFile({super.key});

  @override
  State<EncryptFile> createState() => _EncryptFileState();
}

class _EncryptFileState extends State<EncryptFile> {
  String ecryptedFile = "";
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromLength(16);
  late final encrypt.Encrypter encrypter;

  @override
  void initState() {
    super.initState();
    encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  Future<void> _encryptedFile(String assetPath) async {
    final fileBytes = await rootBundle.load(assetPath);
    final fileData = fileBytes.buffer.asUint8List();

    final encrypted = encrypter.encryptBytes(fileData, iv: iv);

    setState(() {
      ecryptedFile = encrypted.base64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  _encryptedFile('assets/files/Hallo.pdf');
                },
                child: const Text(
                  "Encrypt File PDF",
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  _encryptedFile('assets/files/Hallo.docx');
                },
                child: const Text(
                  "Encrypt File Word",
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  _encryptedFile('assets/files/pr.xlsx');
                },
                child: const Text(
                  "Encrypt File Excel",
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  _encryptedFile('assets/images/tmli.jpeg');
                },
                child: const Text(
                  "Encrypt File Image",
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ),
          ],
        ),
        Text(
          ecryptedFile,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
