import 'package:hedefim/Gider.dart';

import 'VeritabaniYrd.dart';

class Giderlerdao{
  Future<List<Gider>> tumGiderler() async{
    var db = await VeritabaniYardimcisi.vtErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM gider");


    return List.generate(maps.length, (i){
      var satir = maps[i];
      var giderim = Gider(satir["ID"], satir["tur"], satir["tutar"], satir["tarih"], satir["ad"]);

      return giderim;
    });
  }
  Future<void> silik(int id)async{
    var db = await VeritabaniYardimcisi.vtErisim();

    await db.delete("gider",where: "ID = ?",whereArgs: [id]);
  }
}