import 'package:filmler_app/Comment.dart';
import 'package:filmler_app/Filmler.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {
  final Filmler film;

  DetaySayfa({required this.film});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  void _showDownloadingSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Downloading..."),
        duration: Duration(seconds: 2), // Mesajın ne kadar süre görünmesini istediğinizi ayarlayın
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800], // AppBar arka plan rengini gri yapar
        foregroundColor: Colors.white, // Yazı rengini beyaz yapar
        title: Text(widget.film.film_ad),
      ),
      body: Container(
        color: Colors.grey[900], // Body arka plan rengini koyu gri yapar
        child: Center( // Ekranın merkezinde yer alacak
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0), // Etrafında boşluk bırakır
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Dikey ortalama
                crossAxisAlignment: CrossAxisAlignment.center, // Yatay ortalama
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Comment()),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5, // Görselin yüksekliği ekranın %50'si
                      width: MediaQuery.of(context).size.width * 0.5, // Görselin genişliği ekran genişliğinin %50'si
                      child: Image.asset(
                        "resimler/${widget.film.film_resim}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0), // Metinler arasında boşluk
                  Text(
                    widget.film.film_yil.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0), // Metinler arasında boşluk
                  Text(
                    widget.film.yonetmen.yonetmen_ad,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _showDownloadingSnackbar,
                    child: Text("Download",style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red, // Buton üzerindeki yazının rengini ayarlayın
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
