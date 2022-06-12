import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'VeritabaniYrd.dart';

class gelirEkleSayfasiShow extends StatefulWidget {
  const gelirEkleSayfasiShow({Key? key}) : super(key: key);

  @override
  State<gelirEkleSayfasiShow> createState() => _gelirEkleSayfasiShowState();
}

class _gelirEkleSayfasiShowState extends State<gelirEkleSayfasiShow> {


  var tutarTextControl = TextEditingController();
  String tutarGirdi = "Henüz Girilmedi";
  int? secilenTur = null;

  Future<void> Ekle(int tutar, int? turu) async{
    var db = await VeritabaniYardimcisi.vtErisim();
    var bilgiler = Map<String,dynamic>();

    bilgiler["tutar"] = tutar;
    bilgiler["tur"] = turu;
    await db.insert("cuzdan", bilgiler);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gelir Ekle"),
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
                    controller: tutarTextControl,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Tutar",
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Gelir Türü"),
                      DropdownButton<int>(
                        menuMaxHeight: 200,
                        dropdownColor: Colors.blue,
                        hint: Text("Tür",style: TextStyle(color: Colors.black),),
                        items: const [
                          DropdownMenuItem(
                            child: Text(
                              "Kira",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Maaş",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Kazanç",
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
              tutarGirdi = tutarTextControl.text;
              await Ekle(int.parse(tutarGirdi), secilenTur);
              setState(() {
                tutarTextControl.clear();
                secilenTur = null;
              });
            },
              child: Icon(Icons.add),)
          ],
        ),
      ),
    );
  }
}
