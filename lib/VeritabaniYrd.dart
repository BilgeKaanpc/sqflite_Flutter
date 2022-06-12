
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class VeritabaniYardimcisi{

  static final String veritabaniAdi = "hedefim.sqlite";

  static Future<Database> vtErisim() async{
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi);
    if(await databaseExists(veritabaniYolu)){
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);


    }
    return openDatabase(veritabaniYolu);
  }
}