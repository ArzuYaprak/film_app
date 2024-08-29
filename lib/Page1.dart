import 'package:filmler_app/Kategorilerdao.dart';
import 'package:flutter/material.dart';
import 'FilmlerSayfa.dart';
import 'Kategoriler.dart';

class PageA extends StatefulWidget {
  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  Future<List<Kategoriler>> tumKategorileriGoster() async {
    var kategoriListesi = await Kategorilerdao().tumKategoriler();
    return kategoriListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar rengini yarı saydam beyaz yapıyoruz
        title: Text(
          "CATEGORIES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Yazı rengini siyah yapıyoruz
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "resimler/sinema.png",
              fit: BoxFit.cover, // Resmi ekrana tam yaymak için BoxFit.cover kullanıyoruz
            ),
          ),
          // Kategorileri listeleyen FutureBuilder
          FutureBuilder<List<Kategoriler>>(
            future: tumKategorileriGoster(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var kategoriListesi = snapshot.data;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16), // Yukarıdan ve aşağıdan padding
                  itemCount: kategoriListesi!.length,
                  itemBuilder: (context, index) {
                    var kategori = kategoriListesi[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilmlerSayfa(
                              kategori: kategori,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Kartlar arasında daha dengeli boşluk
                        child: Padding(
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: Card(
                            color: Colors.white54.withOpacity(0.7), // Kart arka planını yarı saydam yapıyoruz
                            child: SizedBox(
                              height: 120, // Kartın yüksekliği biraz azaltıldı
                              child: Center(
                                child: Text(
                                  kategori.kategori_ad,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


