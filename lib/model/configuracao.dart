class Configuracao {
  String _nome = "";
  double _altura = 0;

  Configuracao.vazio() {
    _nome = "";
    _altura = 0;
  }

  Configuracao(this._nome, this._altura);

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
}
