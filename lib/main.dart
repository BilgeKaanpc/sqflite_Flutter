import 'package:flutter/material.dart';
import 'package:hedefim/AlinacakEkleSayfasi.dart';
import 'package:hedefim/AlinacaklarSayfasi.dart';
import 'package:hedefim/GelirEkleSayfasi.dart';
import 'package:hedefim/GiderTur.dart';
import 'package:hedefim/GiderlerSayfasi.dart';
import 'package:hedefim/GelirlerSayfasi.dart';
import 'package:hedefim/VeritabaniYrd.dart';

import 'Alinacaklar.dart';
import 'Alinacaklardao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hedefim'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  void test(){
    _MyHomePageState().state();
  }
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {



 void state(){
   setState(() {
     print("Güncellendi");
   });
 }

void hedefEkleSayfasi(){
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AlinacakEkleSayfasi()));

  var deneme = VeritabaniYardimcisi.vtErisim();
}
void gelirEkleSayfasi(){
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => gelirEkleSayfasiShow()));
}
void gelirlerSayfasi(){
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => GelirlerSayfasiShow()));
}
void giderlerSayfasi(){
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => giderlerSayfasiShow()));
}
void alinacaklarSayfasi(){
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AlinacaklarSayfasiShow()));
}

Future<List<Alinacaklar>> tumAlinacaklar ()async{
  var alinacaklarList = await Alinacaklardao().tumAlinacaklar();
  print(alinacaklarList.length);
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
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.red.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(

                gradient: LinearGradient(
                    colors: [Colors.deepOrangeAccent, Colors.green],
                    begin: Alignment(-1.0,-1.0),
                    end: Alignment(-0.5,-0.5),
                    tileMode: TileMode.mirror
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: FutureBuilder<List<Alinacaklar>>(
                future: tumAlinacaklar(),
                builder: (context,snapshot) {
                  var alinacaklarListesi = snapshot.data;


                  return ListView.builder(
                    itemCount: alinacaklarListesi!.length,
                    itemBuilder: (context, index) {
                      var alinacak = alinacaklarListesi[index];
                      var rengim = Colors.white30;
                      var turListesi = ["boş","Teknoloji","Market","Kıyafet"];
                      var tur =  turListesi[alinacak.tur_ID];
                      return GestureDetector(
                        onTap: (){
                        },
                        onDoubleTap: ()async{

                          await giderEkle(alinacak.tur_ID, alinacak.fiyat, alinacak.ad);
                          await Alinacaklardao().hedefSil(alinacak.ID);
                          setState((){
                            print("silindi");

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
              height: 200,
              width: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: gelirlerSayfasi, child: Text("Gelirler"),style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(39, 133, 123, 100),
                      minimumSize: const Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),),
                    Container(
                      height: 5,
                    ),
                    ElevatedButton(onPressed: giderlerSayfasi, child: Text("Giderler"),style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(39, 133, 123, 100),
                      minimumSize: const Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),),

                  ],
                ),
                ElevatedButton(onPressed: alinacaklarSayfasi, child: Text("Alınacaklar",style: TextStyle(fontSize: 20),),style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(39, 133, 123, 100),
                  minimumSize: const Size(150, 145),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              FloatingActionButton(onPressed: gelirEkleSayfasi,
              child: Icon(Icons.account_balance_wallet),),
              FloatingActionButton(onPressed: hedefEkleSayfasi,
              child: Icon(Icons.add),),
            ],)

          ],

        ),
      )

    );
  }
}
