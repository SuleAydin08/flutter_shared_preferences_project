import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_project/login_page.dart';
import 'package:flutter_shared_preferences_project/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _kullaniciAdi = "";
  @override
  void initState() {
    super.initState();
    //Biz bu fonksiyonu ekran açıldığında bir kere yapılmasını istiyoruz.Bu işlemi yapmanın yapılmayacağıda build fonksiyonudur. Çünkü tekrar tekrar çalışır.
    //Bu sebeple init state kullanılır.İnit state uygulama çalıştığında tek yapmasını istediğimi işlemler için kullanırız.
    //Ekran çizilsin bu fonkisyonu öyle çalıştır anlamına geliyor bu kod
    //WidgetsBinding.instance.addPostFrameCallback Flutterda widget ağacının bir çerçevesi çizildikten sonra belirli işlemi gerçekleştirmek için kullanılır.
    //Ui güncellemeleri , animasyonlar ve ilk yükleme işlemlerinde faydalıdır.
    //contextle çalıştığımızda WidgetsBinding.instance.addPostFrameCallback context tamamen hazır olduğunda çalışmasını sağlar. Ancak bunu yazmadan 
    //kullanırsak context hazır olur olmadığını bilmediğimizden bitmedende calıştırmış olabiliriz bu bize bunu garantiye almamızı sağlar.
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserName(context);
    });
  }

//Biz uygulamayı her restart ettiğimizde uygulama yeniden başlatılır ve veriyi tutmaz veri kaybolur.Burada veri kaydetmek için shared preferences kullanırız.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }

  void _checkUserName(BuildContext context) async {
    //Kullanıcı adını kontrol etmeden önce veriyi okuma işlemi yapılır.
    //Veriyi okuma
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Diğer verileri kontrol etmek için;
    //Null olabileceği için null yaparız.
    int? tamSayi = prefs.getInt("tamSayi");
    List<String>? sehirler = prefs.getStringList("sehirler");
    //Burada önemli olan login sayfasındaki set keyi ile burdaki getin keyi aynı olmalıdır.
    //Burda adın null olması durumnunda aşağıdaki kodu yazdık.
    _kullaniciAdi = prefs.getString("kullaniciAdi") ?? "";
    if (_kullaniciAdi.isEmpty) {
      _openLoginPage(context);
    } else {
      _openWelcomePage(context);
    }
  }

  void _openLoginPage(BuildContext context) {
    _openPage(context, LoginPage());
  }

  void _openWelcomePage(BuildContext context) {
    _openPage(context, WelcomePage(_kullaniciAdi));
  }

  //Üsteki iki fonksiyon birbirine benzediği için ortak fonksiyon oluşturuyoruz.
  void _openPage(BuildContext context, Widget sayfa) {
    MaterialPageRoute sayfaYolu =
        MaterialPageRoute(builder: (BuildContext context) {
      //Burada controllen içerisine yazılan text alınır ve diğer sayfaya gidilir.
      return sayfa;
    });
    Navigator.push(context, sayfaYolu);
  }
}
