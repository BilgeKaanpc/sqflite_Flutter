import 'package:flutter/material.dart';
import 'package:hedefim/Alinacaklar.dart';
import 'package:hedefim/Alinacaklardao.dart';

import 'VeritabaniYrd.dart';

class AlinacaklarSayfasiShow extends StatefulWidget {
  const AlinacaklarSayfasiShow({Key? key}) : super(key: key);

  @override
  State<AlinacaklarSayfasiShow> createState() => _AlinacaklarSayfasiShowState();
}

class _AlinacaklarSayfasiShowState extends State<AlinacaklarSayfasiShow>{

  Future<List<Alinacaklar>> tumAlinacaklar ()async{
    var alinacaklarList = await Alinacaklardao().tumAlinacaklar();
    return alinacaklarList;
  }

  Future<void> giderEkle(int tur, int tutar, String ad) async{
    var db = await VeritabaniYardimcisi.vtErisim();
    var bilgiler = Map<String,dynamic>();

    bilgiler["tutar"] = tutar;
  bilgiler["tur"] = tur;
  bilgiler["ad"] = ad;
    await db.insert("gider", bilgiler);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Hedefler"),
        ),
        body: Container(
          color: Colors.red.shade200,
          child: FutureBuilder<List<Alinacaklar>>(
            future: tumAlinacaklar(),
            builder: (context,snapshot) {
              var alinacaklarListesi = snapshot.data;
              return ListView.builder(
                itemCount: alinacaklarListesi!.length,
                itemBuilder: (context, index) {
                  var alinacak = alinacaklarListesi[index];
                  var rengim = Colors.blue.shade50;

                  var turListesi = ["boş","Teknoloji","Market","Kıyafet"];
                  var tur =  turListesi[alinacak.tur_ID];
                  return GestureDetector(
                    onTap: (){
                    },
                    onDoubleTap: () async{

                      await giderEkle(alinacak.tur_ID, alinacak.fiyat, alinacak.ad);
                      await Alinacaklardao().hedefSil(alinacak.ID);
                      setState(() {
                        print("eklendi");
                      });
                    },

                    child: Card(

                      elevation: 8,
                      shadowColor: Colors.green,
                      margin: EdgeInsets.all(20),
                      shape:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      color: rengim,
                      child: SizedBox(height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(alinacak.ad),
                            Text(alinacak.fiyat.toString()),
                            Text(tur),
                            Text(alinacak.tarih)
                          ],
                        ),
                      ),
                    ),
                  );

                },
              );
            },
          ),
        )
    );

}

}

