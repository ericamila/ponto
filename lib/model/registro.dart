import 'package:cloud_firestore/cloud_firestore.dart';

class Registro {
  String? id;
  String data;
  String hora;
  int mes;
  int ano;
  bool isEntrada;

  Registro(
      {required this.data,
      required this.hora,
      required this.mes,
      required this.ano,
      required this.isEntrada,
      this.id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "data": data,
      "hora": hora,
      "mes": mes,
      "ano": ano,
      "entrada": isEntrada,
    };
    return map;
  }

  factory Registro.fromMap(DocumentSnapshot<Map<String, dynamic>>map) {
    final Registro model = Registro(
      data: map['data'],
      hora: map['hora'],
      mes: map['mes'],
      ano: map['ano'],
      isEntrada: map['entrada'],
    );
    return model;
  }

  List<Registro> toList(List<Map<String, dynamic>> map) {
    final List<Registro> lista = [];
    for (Map<String, dynamic> linha in map) {
      final Registro model = Registro(
        data: linha['data'],
        hora: linha['hora'],
        mes: linha['mes'],
        ano: linha['ano'],
        isEntrada: linha['entrada'],
      );
      lista.add(model);
    }
    return lista;
  }
}
