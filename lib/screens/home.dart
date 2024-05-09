import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_eletronico/extensions/date_time.dart';
import 'package:ponto_eletronico/screens/search.dart';

import '../confirmation_dialog.dart';
import '../confirmation_dialog_consultar.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime registro = DateTime.now();
  String _feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: (_feedback != '') ? 30 : 0),
              child: (_feedback != '')
                  ? Text(_feedback, textAlign: TextAlign.center)
                  : Container(),
            ),
            TextButton(
              onPressed: _registrarPonto,
              child: const Text('Registrar'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: _consultarPonto,
                child: const Text('Consultar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _registrarPonto() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    bool isEntrada = true;

    showConfirmationDialog(
      context,
      negativeOption: 'Entrada',
      affirmativeOption: 'Saída',
      content: 'Registrar Entrada ou Saída?',
    ).then((value) {
      if (value != null) {
        if (value) {
          isEntrada = !isEntrada;
        }

        registro = (isEntrada) //considentando o Delay de 1 min ;)
            ? DateTime.now().subtract(const Duration(minutes: 1))
            : DateTime.now().add(const Duration(minutes: 1));

        final data = <String, dynamic>{
          "data": registro.formatBrazilianDate,
          "hora": registro.formatBrazilianTime,
          "mes": registro.month,
          "entrada": isEntrada,
        };

        db
            .collection("registro")
            .doc(registro.idGeneration)
            .set(data)
            .then((value) => setState(() {
                  _feedback =
                      '${isEntrada ? 'ENTRADA' : 'SAÍDA'} REGISTRADA:\n '
                      '${registro.formatBrazilianDate} - ${registro.formatBrazilianTime}';
                }))
            .onError(
              (error, stackTrace) => _feedback = error.toString(),
            );
      }
    });
  }

  void _consultarPonto() async {
    showConfirmationDialogConsulta(context).then((value) {
      if (value != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Consulta(
              month: value,
            ),
          ),
        );
      }
    });
  }
}
