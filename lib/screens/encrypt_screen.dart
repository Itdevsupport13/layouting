import 'package:belajar_layouting/widgets/encrypt_file.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptScreen extends StatefulWidget {
  const EncryptScreen({super.key});

  @override
  State<EncryptScreen> createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen> {
  TextEditingController textEditingController = TextEditingController();
  String encryptedText = '';
  String decryptedText = '';
  String ecryptedFile = "";

  late encrypt.Encrypted encrypted;

  // Ensure the key is 32 bytes for AES-256 encryption
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromLength(16);
  late final encrypt.Encrypter encrypter;

  @override
  void initState() {
    super.initState();
    encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Encryption Text",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Enter text to encrypt'),
              ),
              controller: textEditingController,
            ),
            const SizedBox(height: 18),
            Text("Text Encrypt: $encryptedText"),
            const SizedBox(height: 8),
            Text("Text Decrypt: $decryptedText"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    encrypted =
                        encrypter.encrypt(textEditingController.text, iv: iv);
                    setState(() {
                      encryptedText = encrypted.base64;
                      decryptedText = '';
                    });
                  },
                  child: const Text("Encrypt"),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      decryptedText = encrypter.decrypt(encrypted, iv: iv);
                    });
                  },
                  child: const Text("Decrypt"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const EncryptFile(),
            const Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
