import 'package:flutter/material.dart';

class TableCustom{
  static criaTabela({required List<TableRow> rows}) {
    return Table(
        border: const TableBorder(
          horizontalInside: BorderSide(color: Colors.black),
          verticalInside: BorderSide(color: Colors.black),
        ),
        children: rows);
  }

  static criarLinhaTable({required String listaDados}) {
    return TableRow(
      children: listaDados.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: const TextStyle(fontSize: 20.0)),
        );
      }).toList(),
    );
  }
}