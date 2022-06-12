import 'package:flutter/material.dart';
import 'package:hedefim/Giderlerdao.dart';

import 'Gider.dart';

class giderlerSayfasiShow extends StatefulWidget {
  const giderlerSayfasiShow({Key? key}) : super(key: key);

  @override
  State<giderlerSayfasiShow> createState() => _giderlerSayfasiShowState();
}

class _giderlerSayfasiShowState extends State<giderlerSayfasiShow> {

  Future<List<Gider>> tumGiderler ()async{
    var giderList = await Giderlerdao().tumGiderler();
    return giderList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Giderler"),
        ),
      body: Container(
        color: Colors.red.shade200,
        child: FutureBuilder<List<Gider>>(
          future: tumGiderler(),
          builder: (context,snapshot) {
            var giderlerListesi = snapshot.data;
            return ListView.builder(
              itemCount: giderlerListesi!.length,
              itemBuilder: (context, index) {
                var gider = giderlerListesi[index];
                var rengim = Colors.yellow.shade50;
                var turListesi = ["boş","Teknoloji","Market","Kıyafet"];
                var tur = turListesi[gider.gider_tur];
                return GestureDetector(
                  onTap: ()async{

                    await Giderlerdao().silik(gider.gider_ID);
                    setState(() {
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
                          Text(gider.gider_Ad),
                          Text(gider.gider_tutar.toString()),
                          Text(tur),
                          Text(gider.gider_tarih)
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          },
        ),
      ),
    );
  }
}
