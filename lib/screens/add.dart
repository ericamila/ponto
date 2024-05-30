import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_eletronico/extensions/date_time.dart';
import 'package:ponto_eletronico/util/app_colors.dart';

import '../main.dart';

class FormRegister extends StatefulWidget {
  final String month;

  const FormRegister({super.key, required this.month});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey _globalKey = GlobalKey();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  bool _isEntrada = true;
  int monthSelected = DateTime.now().month;
  String _feedback = '';
  DateTime? _pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Posterior'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.edit),
          )
        ],
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Data',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _hourController,
                  decoration: const InputDecoration(
                    labelText: 'Hora',
                    filled: true,
                    prefixIcon: Icon(Icons.timer_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  //readOnly: true,
                  onTap: () {},
                  keyboardType: TextInputType.datetime,
                  inputFormatters: const [
                    //TimeText(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Entrada'),
                  Switch(
                    activeColor: AppColor.azul,
                    activeTrackColor: AppColor.cinzaMedio,
                    splashRadius: 50.0,
                    value: _isEntrada,
                    onChanged: (value) => setState(() => _isEntrada = value),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: (_feedback != '') ? 30 : 0),
                child: (_feedback != '')
                    ? Text(_feedback, textAlign: TextAlign.center)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        _registrarPonto();
      },
      label: const Text(
        'SALVAR',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.more_time),
    );
  }

  Future<void> _selectDate() async {
    _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2044),
      confirmText: 'Confirmar',
      locale: const Locale('pt', 'BR'),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateController.text = (_pickedDate!.formatBrazilianDate.split(" ")[0]);
        monthSelected = _pickedDate!.month;
      });
    }
  }

  _registrarPonto() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    bool isEntrada = _isEntrada;

    final data = <String, dynamic>{
      "data": _dateController.text,
      "hora": _hourController.text,
      "mes": monthSelected,
      "entrada": isEntrada,
    };
    db
        .collection(kToken)
        .doc(
            '${_pickedDate.toString().split(" ")[0]} ${_hourController.text}:${DateTime.now().second.toStringAsFixed(6)}')
        .set(data)
        .then(
          (value) => setState(() {
            _feedback = '${isEntrada ? 'ENTRADA' : 'SAÍDA'} REGISTRADA:\n '
                '${_dateController.text} - ${_hourController.text}';
          }),
        )
        .onError(
          (error, stackTrace) => _feedback = error.toString(),
        );

    _dateController.text = '';
    _hourController.text = '';
    _isEntrada = true;
  }
}
