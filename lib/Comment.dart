import 'package:filmler_app/Page1.dart';
import 'package:filmler_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  double _rating = 0; // Yıldız puanı başlangıç değeri
  final TextEditingController _commentController = TextEditingController(); // Yorum alanı için controller

  Future<void>exit() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("userName");
    sp.remove("password");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        title: const Text("What's Your Comment?"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              exit();
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false, // Klavye açıldığında ekranı küçültmesini engeller
      body: Container(
        color: Colors.grey[700],
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    "Rate the Movie",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),

                  // Yıldız Puanlama Bölümü
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber, // Yıldız rengi
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating; // Yıldız sayısını günceller
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Yorum yapma bölümü
                  const Text(
                    "Your Comment",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),

                  // Yorum yazmak için TextField
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Write your comment here...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Yıldız puanını ve yorumu ekrana basan buton
                  ElevatedButton(
                    onPressed: () {
                      // Klavyeyi kapat
                      FocusScope.of(context).unfocus();

                      // Yorum ve yıldız puanını ekrana yazdırabiliriz
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Your Review"),
                            content: Text(
                                "Rating: $_rating\nComment: ${_commentController.text}"),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: const Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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