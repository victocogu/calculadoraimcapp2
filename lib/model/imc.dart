import 'package:hive/hive.dart';

part 'imc.g.dart';

@HiveType(typeId: 0)
class Imc extends HiveObject {
  @HiveField(0)
  double _peso = 0;

  @HiveField(1)
  double _altura = 0;

  Imc.vazio() {
    _peso = 0;
    _altura = 0;
  }

  Imc(this._peso, this._altura);

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double calculaIMC() {
    return _peso / (_altura * _altura);
  }

  String getClassificacaoIMC() {
    double valorIMC = calculaIMC();
    String classificacao = "";
    if (valorIMC < 16) {
      classificacao = "Magreza grave";
    } else if (valorIMC < 17) {
      classificacao = "Magreza moderada";
    } else if (valorIMC < 18.5) {
      classificacao = "Magreza leve";
    } else if (valorIMC < 25) {
      classificacao = "Saudável";
    } else if (valorIMC < 30) {
      classificacao = "Sobrepeso";
    } else if (valorIMC < 35) {
      classificacao = "Obesidade Grau I";
    } else if (valorIMC < 40) {
      classificacao = "Obesidade Grau II (severa)";
    } else {
      classificacao = "Obesidade Grau III (mórbida)";
    }
    return "${valorIMC.toStringAsFixed(2)} - $classificacao";
  }
}
