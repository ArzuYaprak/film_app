import 'package:filmler_app/Page1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> sessionControl() async {
    var sp = await SharedPreferences.getInstance();

    String spUserName = sp.getString("userName") ?? "no user name";
    String spPassword = sp.getString("password") ?? "no password";

    if (spUserName == "ArzuYaprak" && spPassword == "17891453") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: sessionControl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            bool permissionPass = snapshot.data ?? false;
            return permissionPass ? PageA() : LoginScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var tfUserName = TextEditingController();
  var tfPassword = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> enterControl() async {
    var un = tfUserName.text;
    var p = tfPassword.text;

    if (un == "ArzuYaprak" && p == "17891453") {
      var sp = await SharedPreferences.getInstance();

      sp.setString("userName", un);
      sp.setString("password", p);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PageA()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("resimler/movie.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: tfUserName,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: TextStyle(fontSize: 25)
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: tfPassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                        hintStyle: TextStyle(fontSize: 25)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: ElevatedButton(
                      child: Text("Enter",style: TextStyle(fontSize: 25),),
                      onPressed: () {
                        enterControl();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
