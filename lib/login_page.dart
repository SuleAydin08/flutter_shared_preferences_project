import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_project/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[100],
        title: Text("Giriş Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text(
                  "Giriş Yap",
                  style: TextStyle(fontSize: 24),
                ))
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    //Bu kullanıcılara eğer text field içerisi boşsa hata verecek ve diğer sayfalara geçişi engelleyecek
    if (_controller.text.isEmpty) {
    // Eğer text field boşsa uyarı göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Kullanıcı adı boş olamaz!")),
    );
    return; // İşlemi durdur
  }
    //Burada kullanıcının bilgilerini kayıt etmek için bu işlem yapılır.
    //Shared Preferences future döndündüğü için async ve await kullanmak gerekir.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Shared preferences kullanarak 5 türden veri kayıt ediyoruz.
    //KArşılama sayfasına geçmeden veriyi kaydettiğimizden emin olmak için aşağıdaki kodun başına await yazıyoruz.
    await prefs.setString("kullaniciAdi", _controller.text);
    await prefs.setInt("tamSayi", 12);
    await prefs.setDouble("ondalikliSayi", 3.14);
    await prefs.setBool("ikiliDeger", true);

    List<String> sehirler = ["İstanbul", "Adana", "Antalya"];
    await prefs.setStringList("sehirler", sehirler);
    _openWelcomePage(context);
  }

  void _openWelcomePage(BuildContext context) {
    MaterialPageRoute sayfaYolu =
        MaterialPageRoute(builder: (BuildContext context) {
      //Burada controllen içerisine yazılan text alınır ve diğer sayfaya gidilir.
      return WelcomePage(_controller.text);
    });
    Navigator.push(context, sayfaYolu);
  }
}