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
  Color _color = Color.fromRGBO(109, 0, 255, 1);

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double result = weight / (height * height);

      if (result < 18.5) {
        _infoText = "Trate de comer! (${result.toStringAsPrecision(3)})";
      } else if (result > 19.5 && result < 24.9) {
        _infoText = "Peso ideal! (${result.toStringAsPrecision(3)})";
      } else if (result > 25 && result < 29.9) {
        _infoText =
            "Você está pré sobrepeso! (${result.toStringAsPrecision(3)})";
      } else if (result > 30 && result < 34.5) {
        _infoText = "Obesidade grau I! (${result.toStringAsPrecision(3)})";
      } else if (result > 34.6 && result < 39.9) {
        _infoText = "Obesidade grau II! (${result.toStringAsPrecision(3)})";
      } else if (result >= 40) {
        _infoText = "Obesidade grau III! (${result.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: _color,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: _color,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso (kg)"),
                textAlign: TextAlign.center,
                style: TextStyle(color: _color, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura (cm)"),
                textAlign: TextAlign.center,
                style: TextStyle(color: _color, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calc();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: _color),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: _color, fontSize: 25.00),
              )
            ],
          ),
        ),
      ),
    );
  }
}
