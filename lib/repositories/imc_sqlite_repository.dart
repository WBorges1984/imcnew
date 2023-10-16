import 'package:imcnew/model/imc_sqlite_model.dart';
import 'package:imcnew/repositories/sqlitedatabase.dart';

class ImcQLiteRepository {
  Future<List<ImcSQLiteModel>> obterDados() async {
    List<ImcSQLiteModel> imc = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db
        .rawQuery('SELECT id, peso, altura, dtImc, image, saude FROM imc');
    for (var element in result) {
      imc.add(ImcSQLiteModel(
          int.parse(element["id"].toString()),
          double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString()),
          element["dtImc"].toString(),
          element["image"].toString(),
          element["saude"].toString(),
          double.parse(element["resultIMC"].toString())));
    }
    return imc;
  }

  Future<void> salvar(ImcSQLiteModel imcSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'INSERT INTO imc (peso, altura, dtImc,image,saude,resultIMC) values(?,?,?,?,?,?)',
        [
          imcSQLiteModel.peso,
          imcSQLiteModel.altura,
          imcSQLiteModel.dtImc,
          imcSQLiteModel.image,
          imcSQLiteModel.saude,
          imcSQLiteModel.resultIMC
        ]);
  }

  Future<void> atualizar(ImcSQLiteModel imcSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db
        .rawInsert('UPDATE imc SET descricao = ?, concluido = ? WHERE id = ?', [
      imcSQLiteModel.peso,
      imcSQLiteModel.altura,
      imcSQLiteModel.dtImc,
      imcSQLiteModel.id
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
