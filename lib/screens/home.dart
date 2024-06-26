import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_eletronico/extensions/date_time.dart';
import 'package:ponto_eletronico/screens/search.dart';
import '../components/confirmation_dialog.dart';
import '../components/confirmation_dialog_consultar.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime registro = DateTime.now();
  String _feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: (_feedback != '') ? 30 : 0),
              child: (_feedback != '')
                  ? Text(_feedback, textAlign: TextAlign.center)
                  : Container(),
            ),
            ElevatedButton(
                onPressed: _registrarPonto, child: const Text('Registrar')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
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

        final data = <String, dynamic>{
          "data": registro.formatBrazilianDate,
          "hora": registro.formatBrazilianTime,
          "mes": registro.month,
          "entrada": isEntrada,
        };

        db
            .collection(kToken)
            .doc(registro.idGeneration)
            .set(data)
            .then((value) => setState(() {
                  _feedback =
                      '${isEntrada ? 'ENTRADA' : 'SAÍDA'} REGISTRADA:\n '
                      '${registro.formatBrazilianDate} - ${registro.formatBrazilianTime}';
                }))
            .onError((error, stackTrace) => _feedback = error.toString());
      }
    });
  }

  void _consultarPonto() async {
    showConfirmationDialogConsulta(context).then((value) {
      if (value != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Consulta(month: value),
          ),
        );
      }
    });
  }
}
