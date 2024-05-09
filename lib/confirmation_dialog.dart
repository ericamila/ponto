import 'package:flutter/material.dart';
import 'package:ponto_eletronico/app_colors.dart';

Future<dynamic> showConfirmationDialog(BuildContext context,
    {String title = "Atenção!",
    String content = "Você realmente deseja executar essa operação?",
    String affirmativeOption = "Confirmar",
    String negativeOption = "Cancelar"}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            IconButton(
              onPressed: () => Navigator.pop(context, null),
              icon: Icon(
                Icons.close,
                color: AppColor.cinzaEscuro,
              ),
              padding: const EdgeInsets.all(0),
              style: IconButton.styleFrom(backgroundColor: AppColor.cinzaClaro),
            ),
          ],
        ),
        content: Text(content),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(negativeOption),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColor.vermelho),
            child: Text(affirmativeOption),
          ),
        ],
      );
    },
  );
}
