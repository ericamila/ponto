import 'package:flutter/material.dart';
import 'package:ponto_eletronico/extensions/date_time.dart';
import 'package:ponto_eletronico/util/app_colors.dart';

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
                  readOnly: true,
                  onTap: () {

                  },
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
        debugPrint('data ${_dateController.text}\n'
            'hora ${_hourController.text}\n'
            'entrada $_isEntrada\n'
            'mês $monthSelected');
      },
      label: const Text(
        'SALVAR',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.more_time),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2044),
      confirmText: 'Confirmar',
      locale: const Locale('pt', 'BR'),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateController.text = (_pickedDate.formatBrazilianDate.split(" ")[0]);
        monthSelected = _pickedDate.month;
      });
    }
  }
}
