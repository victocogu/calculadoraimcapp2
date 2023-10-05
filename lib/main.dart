import 'package:calculadoraimcapp2/model/imc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'calculador_imc_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(ImcAdapter());

  runApp(const CalculadoraImcApp());
}
