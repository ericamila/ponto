import 'package:flutter/material.dart';

Widget noData({String msg = 'Registros não encontrados!'}) {
  return Container(
    margin: const EdgeInsets.only(top: 120),
    alignment: Alignment.center,
    child: Column(
      children: [
        Icon(
          Icons.data_object_outlined,
          size: 96,
          weight: 0.5,
          color: Colors.grey[700],
        ),
        Text(msg),
      ],
    ),
  );
}

void showSnackBarDefault(BuildContext context,
    {String message = "Registro salvo com sucesso.", bool sucess = true}) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}