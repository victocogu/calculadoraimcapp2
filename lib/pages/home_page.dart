import 'package:calculadoraimcapp2/model/configuracao.dart';
import 'package:calculadoraimcapp2/model/imc.dart';
import 'package:calculadoraimcapp2/pages/configuracoes_page.dart';
import 'package:calculadoraimcapp2/repositories/calculos_imc_repository.dart';
import 'package:calculadoraimcapp2/repositories/configuracoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/widgets/text_label.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConfiguracoesRepository configuracoesRepository;
  late CalculosIMCRepository calculosIMCRepository;
  Configuracao configuracao = Configuracao.vazio();
  var _calculosImc = <Imc>[];

  TextEditingController pesoController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    carregarConfiguracoes();

    calculosIMCRepository = await CalculosIMCRepository.carregar();
    carregarCalculos();
  }

  carregarConfiguracoes() {
    configuracao = configuracoesRepository.getDados();
    alturaController.text = configuracao.altura.toString();
  }

  carregarCalculos() {
    _calculosImc = calculosIMCRepository.getDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Calculador IMC"), actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (bc) => const ConfiguracoesPage())).then((_) {
                carregarConfiguracoes();
                setState(() {});
              });
            },
          )
        ]),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              alignment: Alignment.centerLeft,
              child: TextLabel(texto: "Usuário: ${configuracao.nome}")),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Expanded(flex: 1, child: TextLabel(texto: "Peso:")),
              Expanded(
                flex: 2,
                child: TextField(
                    controller: pesoController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ]),
              ),
              const SizedBox(
                width: 30,
              ),
              const Expanded(flex: 1, child: TextLabel(texto: "Altura:")),
              Expanded(
                flex: 2,
                child: TextField(
                    controller: alturaController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    enabled: false),
              ),
              const SizedBox(
                width: 25,
              ),
              TextButton(
                onPressed: () {
                  Imc calcIMC = Imc(double.parse(pesoController.text),
                      double.parse(alturaController.text));
                  calculosIMCRepository.salvar(calcIMC);
                  pesoController.text = "";
                  carregarCalculos();
                },
                child: const Text("Calcular"),
              ),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _calculosImc.length,
                itemBuilder: (BuildContext bc, int index) {
                  var imc = _calculosImc[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) {
                      calculosIMCRepository.excluir(imc);
                      carregarCalculos();
                    },
                    key: Key(DateTime.now().toString()),
                    child: ListTile(
                      title: Text(
                          "Peso: ${imc.peso}   Altura: ${imc.altura}   IMC: ${imc.getClassificacaoIMC()}"),
                    ),
                  );
                }),
          ),
        ]));
  }
}
