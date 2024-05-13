import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/format_txt.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration: const BoxDecoration(color: Colors.white),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.punch_clock,
                    size: 64,
                    color: Colors.blueGrey,
                  ),
                  const Text("Insira o Token"),
                  TextFormField(
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Preencha este campo'
                          : null;
                    },
                    controller: _tokenController,
                    decoration: const InputDecoration(label: Text("Token")),
                    inputFormatters: [UppCase()],
                  ),
                  TextFormField(
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Preencha este campo'
                          : null;
                    },
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FilledButton(
                        onPressed: () {
                          saveUserInfos(
                            context: context,
                            token: _tokenController.text,
                            name: _nameController.text,
                          );
                        },
                        child: const Text("Continuar")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveUserInfos({
    required BuildContext context,
    required String token,
    required String name,
  }) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", token).then(
      (result) {
        if (result) {
          db
              .collection("accessId")
              .doc(token)
              .set({
                "accessToken": token,
                "name": name,
              })
              .then((value) => Navigator.pushReplacementNamed(context, "home"))
              .onError(
                (error, stackTrace) => showSnackBar(
                    context: context, message: error.toString(), sucess: false),
              );
          kToken = token;
        }
      },
    );

    return token;
  }
}

void showSnackBar({
    required BuildContext context,
    required String message,
    required bool sucess}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (sucess) ? Colors.teal : Colors.orangeAccent,
      behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
