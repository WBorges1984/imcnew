class ImcSQLiteModel {
  int _id = 0;
  double _peso = 0;
  double _altura = 0;
  String _saude = '';
  String _image = '';
  double _resultImc = 0;

  String _dt_imc = '';

  ImcSQLiteModel(this._id, this._peso, this._altura, this._dt_imc, this._image,
      this._saude, this._resultImc);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double concluido) {
    _altura = concluido;
  }

  double get resultIMC => _resultImc;

  set resultIMC(double resultImc) {
    _resultImc = resultImc;
  }

  String get dtImc => _dt_imc;

  set dtImc(String dtImc) {
    _dt_imc = dtImc;
  }

  String get saude => _saude;

  set saude(String saude) {
    _saude = saude;
  }

  String get image => _image;

  set image(String image) {
    _image = image;
  }
}
