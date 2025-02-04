import 'package:filmler_app/Kategoriler.dart';
import 'package:filmler_app/VeritabaniYardimcisi.dart';

class Kategorilerdao {

  Future<List<Kategoriler>> tumKategoriler() async {
    
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
    });
  }
}