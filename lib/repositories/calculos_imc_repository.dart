import 'package:calculadoraimcapp2/model/imc.dart';
import 'package:hive/hive.dart';

class CalculosIMCRepository {
  static late Box _box;

  CalculosIMCRepository._criar();

  static Future<CalculosIMCRepository> carregar() async {
    if (Hive.isBoxOpen("CalculosIMC")) {
      _box = Hive.box("CalculosIMC");
    } else {
      _box = await Hive.openBox("CalculosIMC");
    }
    return CalculosIMCRepository._criar();
  }

  void salvar(Imc imc) {
    _box.add(imc);
  }

  void excluir(Imc imc) {
    imc.delete();
  }

  List<Imc> getDados() {
    return _box.values.cast<Imc>().toList();
  }
}
