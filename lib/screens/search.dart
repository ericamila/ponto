import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_eletronico/components/table.dart';
import 'package:ponto_eletronico/screens/add.dart';
import '../main.dart';
import '../model/registro.dart';
import '../util/common.dart';
import '../util/month.dart';

class Consulta extends StatefulWidget {
  final String month;

  const Consulta({super.key, required this.month});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  List<TableRow> rows = [];
  bool isFull = false;

  @override
  void initState() {
    super.initState();
    _populaVazio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Consulta ${widget.month}'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: status(isFull),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: TableCustom.criaTabela(rows: [
              (TableCustom.criarLinhaTable(listaDados: "Data, Hora, Registro"))
            ]),
          )),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: SingleChildScrollView(
          child: (rows.isEmpty) ? noData() : TableCustom.criaTabela(rows: rows),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormRegister(
              month: widget.month,
            ),
          ),
        ).then((value) {
          if (value != null) {
            (value == true)
                ? showSnackBarDefault(context)
                : showSnackBarDefault(context,
                message: "Houve uma falha ao registar.");
            _refresh();
          }
        });
      },
      label: const Text(
        'ADICIONAR',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.more_time),
    );
  }

  List<TableRow> _populaRows() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    const source = Source.serverAndCache; //para registros off-line
    int mes = Month.string(monthString: widget.month).month;

    rows = [];

    db
        .collection(kToken)
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
    }).then(
      (value) => setState(
        () {
          isFull = true;
        },
      ),
    );

    return rows;
  }

  List<TableRow> _populaVazio() {
    _populaRows();
    setState(() {});
    return rows;
  }

  Widget status(bool isFull) {
    return (isFull)
        ? const Icon(Icons.calendar_month_outlined)
        : const CircularProgressIndicator();
  }

  Future<void> _refresh() async {
    setState(() {});
    _populaVazio();
  }
}
