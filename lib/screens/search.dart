import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_eletronico/components/table.dart';
import '../model/registro.dart';
import '../month.dart';

class Consulta extends StatefulWidget {
  final String month;

  const Consulta({super.key, required this.month});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  List<TableRow> rows = [];

  @override
  void initState() {
    super.initState();
    _populaVazio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta')),
      body: (rows.isEmpty)
          ? const Center(
              child: Text('Sem resultados!'),
            )
          : TableCustom.criaTabela(rows: rows),
    );
  }

  List<TableRow> _populaRows() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    const source = Source.serverAndCache; //para registros off-line
    int mes = Month.string(monthString: widget.month).month;

    db
        .collection("registro")
        .where("mes", isEqualTo: mes)
        .get(const GetOptions(source: source))
        .then((event) {
      for (var doc in event.docs) {
        Registro model = Registro.fromMap(doc);
        TableRow row = TableCustom.criarLinhaTable(
            listaDados:
                "${model.data}, ${model.hora}, ${model.isEntrada ? 'Entrada' : 'Saída'}");
        rows.add(row);
      }
    }).then((value) => setState(() {}));

    return rows;
  }

  List<TableRow> _populaVazio() {
    rows.add(TableCustom.criarLinhaTable(listaDados: "Data, Hora, Registro"));
    _populaRows();
    setState(() {});
    return rows;
  }
}
