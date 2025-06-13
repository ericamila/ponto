import 'package:flutter/material.dart';

Future<dynamic> showConfirmationDialogConsulta(
  BuildContext context, {
  String title = "Selecione o mês!",
  String affirmativeOption = "Confirmar",
}) {
  final TextEditingController monthController = TextEditingController();
  int mesAnteror = DateTime.now().month - 1;
  String selectedMonth = meses[mesAnteror]; //Mes atual
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: DropdownMenu<String>(
            width: MediaQuery.of(context).size.width * .62,
            controller: monthController,
            initialSelection: selectedMonth,
            requestFocusOnTap: true,
            label: const Text('Mês'),
            hintText: selectedMonth,
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            ),
            onSelected: (String? value) {
              selectedMonth = value.toString();
            },
            dropdownMenuEntries: meses.map<DropdownMenuEntry<String>>(
              (String mes) {
                return DropdownMenuEntry<String>(
                  value: mes,
                  label: mes,
                );
              },
            ).toList(),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, selectedMonth);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red[900]),
            child: Text(affirmativeOption),
          ),
        ],
      );
    },
  );
}

const meses = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro'
];
