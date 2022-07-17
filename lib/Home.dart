import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "Resultado";
  TextEditingController _controllerCep = TextEditingController();

  void _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}";
    });

    print(
        "Resposta logradouro:  ${logradouro} complemento: ${complemento} bairro ${bairro}");
    //  print("Resposta: " + response.statusCode.toString());
    //  print("Resposta: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite o CEP"),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 30),
              child: RaisedButton(
                child: Text(
                  "Buscar",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                onPressed: _recuperarCep,
              ),
            ),
            Text(_resultado,
            style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold
            ),
            ),
          ],
        ),
      ),
    );
  }
}
