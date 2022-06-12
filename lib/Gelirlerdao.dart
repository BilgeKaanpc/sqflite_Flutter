import 'package:hedefim/Alinacaklar.dart';
import 'package:hedefim/Cuzdan.dart';
import 'package:hedefim/VeritabaniYrd.dart';

class Gelirlerdao{
  Future<List<Cuzdan>> tumGelirler() async{
    var db = await VeritabaniYardimcisi.vtErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM cuzdan");
    return List.generate(maps.length, (i){
      var satir = maps[i];
      var gelir = Cuzdan(satir["ID"], satir["tur"], satir["tutar"], satir["tarih"]);

      return gelir;
    });
  }

}