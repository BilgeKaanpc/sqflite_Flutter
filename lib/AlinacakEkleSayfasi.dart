import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hedefim/VeritabaniYrd.dart';
import 'package:hedefim/main.dart';

class AlinacakEkleSayfasi extends StatefulWidget {
  const AlinacakEkleSayfasi({Key? key}) : super(key: key);

  @override
  State<AlinacakEkleSayfasi> createState() => _AlinacakEkleSayfasiState();
}

class _AlinacakEkleSayfasiState extends State<AlinacakEkleSayfasi> {

  Future<void> Ekle(String adi,int fiyati, int? turu) async{
    var db = await VeritabaniYardimcisi.vtErisim();
    var bilgiler = Map<String,dynamic>();

  bilgiler["ad"] = adi;
  bilgiler["fiyat"] = fiyati;
  bilgiler["tur_ID"] = turu;
  print(adi+turu.toString() + fiyati.toString());
  await db.insert("alinacaklar", bilgiler);
  }


  var adTextControl = TextEditingController();
  String adGirdi = "Henüz Girilmedi";
  var fiyatControl = TextEditingController();
  String fiyatGirdi = "Henüz Girilmedi";
  int? secilenTur = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hedef Ekle"),
      ),
      body: Container(
        color: Colors.red.shade200,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                ),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.black26],
                ),
              ),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: adTextControl,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Ürünün Adı",
                    ),),
                  TextField(
                    controller: fiyatControl,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Ürünün Fiyatı",
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ürünün Türü:"),
                      DropdownButton<int>(
                        menuMaxHeight: 200,
                        dropdownColor: Colors.blue,
                        hint: Text("Tür",style: TextStyle(color: Colors.black),),
                        items: const [
                          DropdownMenuItem(
                            child: Text(
                              "Teknoloji",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Market",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Kıyafet",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 3,
                          ),
                        ],
                        value: secilenTur,
                        onChanged: (int? yeniTur) {
                          setState(() {
                            secilenTur = yeniTur;
                          });
                        },
                      ),],
                  ),
                ],
              ),
            ),
            FloatingActionButton(onPressed: ()async{

              adGirdi = adTextControl.text;
              fiyatGirdi = fiyatControl.text;
              await Ekle(adGirdi,int.parse(fiyatGirdi),secilenTur);
              setState((){
                adTextControl.clear();
                fiyatControl.clear();
                secilenTur = null;
                print("eklendi");
              });
            },
            child: Icon(Icons.add),)
          ],
        ),
      ),
    );
  }
}
