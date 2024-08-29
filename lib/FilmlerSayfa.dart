import 'package:flutter/material.dart';
import 'package:filmler_app/DetaySayfa.dart';
import 'package:filmler_app/Filmler.dart';
import 'package:filmler_app/Filmlerdao.dart';
import 'package:filmler_app/Kategoriler.dart';

class FilmlerSayfa extends StatefulWidget {
  final Kategoriler kategori;

  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  Future<List<Filmler>> filmlerGoster(int kategoriId) async {
    return await Filmlerdao().tumFilmlerByKategoriId(kategoriId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Arka plan rengini siyah yapar
        foregroundColor: Colors.white, // Yazı rengini beyaz yapar
        title: Text("Films : ${widget.kategori.kategori_ad}"),
      ),
      body: Container(
        color: Colors.black, // Arka plan rengini siyah yapar
        child: FutureBuilder<List<Filmler>>(
          future: filmlerGoster(widget.kategori.kategori_id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Hata: ${snapshot.error}", style: TextStyle(color: Colors.white)));
            } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
              var filmlerListesi = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),  // Etrafına padding ekleyin
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,  // Aspect ratio'yu biraz küçültün
                  crossAxisSpacing: 8.0,  // Grid elemanları arasına boşluk ekleyin
                  mainAxisSpacing: 8.0,
                ),
                itemCount: filmlerListesi.length,
                itemBuilder: (context, index) {
                  var film = filmlerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetaySayfa(film: film),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[850], // Kartların arka plan rengini koyu gri yapar
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "resimler/${film.film_resim}",
                                fit: BoxFit.cover,  // Resim uyumunu ayarlayın
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              film.film_ad,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("Veri bulunamadı.", style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}
