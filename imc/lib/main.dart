import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _info = "Informe seus dados.";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoController =  TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _resetFields(){
    pesoController.text = '';
    alturaController.text = '';
    setState((){
      _info = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState((){
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      double imc = peso / (altura * altura);

      print(imc);
      if (imc <18.6){
        _info = 'Abaixo do peso, IMC (${imc.toStringAsPrecision(3)})';
      } else if (imc >=18.6 && imc < 24.9){
         _info = 'Peso ideal, IMC (${imc.toStringAsPrecision(3)})';
      } else if (imc >=24.9 && imc < 29.9){
         _info = 'Acima do peso, IMC (${imc.toStringAsPrecision(3)})';
      }else if (imc >=29.9 && imc < 34.9){
         _info = 'Obesidade Grau I, IMC (${imc.toStringAsPrecision(3)})';
      }else if (imc >=34.9 && imc < 39.9){
         _info = 'Obesidade Grau II, IMC (${imc.toStringAsPrecision(3)})';
      }else{
         _info = 'Obesidade Grau III, IMC (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields)
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
              const Icon(Icons.person_outline,
              size: 120.0, color: Colors.indigo),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.indigo)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.indigo, fontSize: 25.0),
                controller: pesoController,
                validator: (value){
                  if (value!.isEmpty){
                    return "Insira seu peso!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.indigo)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.indigo, fontSize: 25.0),
                controller: alturaController,
                validator: (value){
                  if (value!.isEmpty){
                    return "Insira sua altura!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        _calcular();
                      }
                    },
                    color: Colors.indigo,
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.indigo, fontSize: 25.0),
              )
            ],
          ),
        )));
  }
}