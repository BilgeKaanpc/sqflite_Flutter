import 'package:flutter/material.dart';
import 'package:hedefim/Gelirlerdao.dart';

import 'Cuzdan.dart';

class GelirlerSayfasiShow extends StatefulWidget {
  const GelirlerSayfasiShow({Key? key}) : super(key: key);

  @override
  State<GelirlerSayfasiShow> createState() => _GelirlerSayfasiShowState();
}

class _GelirlerSayfasiShowState extends State<GelirlerSayfasiShow> {

  Future<List<Cuzdan>> tumGelirler ()async{
    var gelirlerList = await Gelirlerdao().tumGelirler();
    return gelirlerList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gelirler"),
        ),
      body: Container(
        color: Colors.red.shade200,
        child: FutureBuilder<List<Cuzdan>>(
          future: tumGelirler(),
          builder: (context,snapshot) {
            var gelirlerListesi = snapshot.data;
            return ListView.builder(
              itemCount: gelirlerListesi!.length,
              itemBuilder: (context, index) {
                var gelir = gelirlerListesi[index];

                var turListesi = ["boş","Kira","Maaş","Kazanç"];
                var tur = turListesi[gelir.tur];
                return GestureDetector(
                  onTap: (){
                  },
                  child: Card(

                    elevation: 8,
                    shadowColor: Colors.green,
                    margin: EdgeInsets.all(20),
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    color: Colors.red.shade50,
                    child: SizedBox(height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(gelir.tutar.toString()),
                          Text(tur),
                          Text(gelir.tarih)

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
