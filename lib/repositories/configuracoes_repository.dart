import 'package:calculadoraimcapp2/model/configuracao.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._criar();

  static Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen("Configuracoes")) {
      _box = Hive.box("Configuracoes");
    } else {
      _box = await Hive.openBox("Configuracoes");
    }
    return ConfiguracoesRepository._criar();
  }

  void salvar(Configuracao configuracao) {
    _box.put("Configuracoes", {
      "nome": configuracao.nome,
      "altura": configuracao.altura,
    });
  }

  Configuracao getDados() {
    var configuracao = _box.get("Configuracoes");
    if (configuracao == null) {
      return Configuracao.vazio();
    }
    return Configuracao(configuracao["nome"], configuracao["altura"]);
  }
}
