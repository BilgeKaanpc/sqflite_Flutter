import 'package:hedefim/Alinacaklar.dart';
import 'package:hedefim/VeritabaniYrd.dart';

class Alinacaklardao{
  Future<List<Alinacaklar>> tumAlinacaklar() async{
    var db = await VeritabaniYardimcisi.vtErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM alinacaklar");
    return List.generate(maps.length, (i){
      var satir = maps[i];
      var kisim = Alinacaklar(satir["ID"],satir["tur_ID"],satir["ad"],satir["tarih"],satir["fiyat"]);

      return kisim;
    });
  }

  Future<void> hedefSil(int id)async{
    var db = await VeritabaniYardimcisi.vtErisim();

    await db.delete("alinacaklar",where: "ID = ?",whereArgs: [id]);
  }
}