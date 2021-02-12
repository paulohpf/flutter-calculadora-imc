import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _appBarTitle = 'Calculadora de ICM';
  String _infoText = 'Informe seus dados';

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {});
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seus dados';
      _formKey.currentState.reset();
    });
  }

  void _calculate() {
    setState(() {
      final double weight = double.parse(weightController.text);
      final double height = double.parse(heightController.text) / 100;

      final double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 24),
                controller: weightController,
                validator: (String value) {
                  return value.isEmpty ? 'Insira seu peso!' : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 24),
                controller: heightController,
                validator: (String value) {
                  return value.isEmpty ? 'Insira sua altura!' : null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
