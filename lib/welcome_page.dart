import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  String _userName;

  WelcomePage(this._userName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Karşılama Sayfası"),
      ),
      body: Center(
        child: Text(
          "Hoşgeldin $_userName",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}