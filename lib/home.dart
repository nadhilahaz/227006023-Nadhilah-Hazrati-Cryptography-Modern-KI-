import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final ctrlText = TextEditingController();
final ctrlKey = TextEditingController();
final ctrlEncryptedText = TextEditingController();
final ctrlDecryptedText = TextEditingController();

var cipherText = 'empty text';
var plainText = 'empty text';
encrypt.Encrypted? encrypted;

//  final key = encrypt.Key.fromSecureRandom(32);
var key = encrypt.Key.fromUtf8(ctrlKey.text);
final encrypter = encrypt.Encrypter(encrypt.AES(key));
final iv = encrypt.IV.fromSecureRandom(16);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool obscureText = true; // Deklarasi variabel obscureText

  void encryptText(String text) {
    final plainText = text;
    encrypted = encrypter.encrypt(plainText, iv: iv);

    cipherText = encrypted!.base64;
    ctrlEncryptedText.text = cipherText; // Setel nilai hasil enkripsi ke dalam TextField
    setState(() {});
    // debugPrint(encrypted.base64);
    debugPrint(cipherText);
  }

  void decryptText() {
    final decrypted = encrypter.decrypt(encrypted!, iv: iv);
    plainText = decrypted;

    ctrlDecryptedText.text = plainText; // Setel nilai hasil dekripsi ke dalam TextField
    setState(() {});
    debugPrint(decrypted);
  }

  void reset() {
    ctrlText.clear();
    ctrlKey.clear();
    ctrlEncryptedText.clear();
    ctrlDecryptedText.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '227006023 Nadhilah Hazrati Cryptography Modern',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cryptography Modern AES'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 550,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: ctrlText,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Text',
                      hintText: 'Masukkan text untuk dienkripsi',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ctrlKey,
                    maxLength: 32,
                    style: const TextStyle(color: Colors.black),
                    obscureText: obscureText, // Menyembunyikan teks berdasarkan nilai variabel obscureText
                    obscuringCharacter: '*', // Mengganti teks yang disensor dengan karakter tertentu
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Secret Key',
                      hintText: 'Masukkan secret key',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      key = encrypt.Key.fromUtf8(value);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: (ctrlText.text.isNotEmpty) && (ctrlKey.text.length == 32)
                            ? () {
                                encryptText(ctrlText.text);
                              }
                            : null,
                        child: const Text('Enkripsi'),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {
                          decryptText();
                        },
                        child: const Text(
                          "Dekripsi",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ctrlEncryptedText,
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hasil Enkripsi',
                      hintText: 'Hasil enkripsi akan muncul di sini',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ctrlDecryptedText,
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hasil Dekripsi',
                      hintText: 'Hasil dekripsi akan muncul di sini',
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: reset,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
