import 'package:flutter/material.dart';
import 'login_page.dart'; // EKLE

class UserFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Sayfası"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Çıkış yap',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/eru_logo.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 20),
            Text(
              "Erciyes Üniversitesi Bilgisayar Mühendisliği Bölümü",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
