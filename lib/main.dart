import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String infoText = "Informe seus Dados";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      infoText = "Informe seus Dados";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
        print(imc);
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso Ideal (${imc.toStringAsPrecision(2)})";
        print(imc);
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
        print(imc);
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
        print(imc);
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
        print(imc);
      } else if (imc >= 40) {
        infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        print(imc);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[700],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline,
                  size: 120, color: Colors.greenAccent[700]),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
                autofocus: true,
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso(Kg)',
                  labelStyle: TextStyle(color: Colors.greenAccent[700]),
                  alignLabelWithHint: true,
                  hintText: '50.0 kg',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent[700], fontSize: 15),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
                autofocus: false,
                controller: heightController,
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura(cm)',
                  labelStyle: TextStyle(color: Colors.greenAccent[700]),
                  alignLabelWithHint: true,
                  hintText: '50.0 kg',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent[700], fontSize: 15),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        onPressed: () {
                          // ignore: unnecessary_statements
                          if (_formkey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text('Calcular',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        color: Colors.greenAccent[700])),
              ),
              Text('$infoText',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}
