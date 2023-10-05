import 'package:calculadoraimcapp2/model/configuracao.dart';
import 'package:calculadoraimcapp2/repositories/configuracoes_repository.dart';
import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late ConfiguracoesRepository configuracoesRepository;
  Configuracao configuracao = Configuracao.vazio();

  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracao = configuracoesRepository.getDados();

    nomeController.text = configuracao.nome;
    alturaController.text = configuracao.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Configurações")),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome"),
                controller: nomeController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              ),
            ),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    configuracao.altura = double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Calculadora ICM"),
                            content:
                                const Text("Favor informar uma altura válida!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          );
                        });
                    return;
                  }
                  configuracao.nome = nomeController.text;
                  configuracoesRepository.salvar(configuracao);
                  Navigator.pop(context);
                },
                child: const Text("Salvar"))
          ],
        ),
      ),
    );
  }
}
