// ===========================================================
// Erciyes Üniversitesi - Mühendislik Fakültesi
// Bilgisayar Mühendisliği Bölümü
// Dersi: MOBILE APPLICATION DEVELOPMENT
// Öğretim Üyesi: [Dr. Öğr. Üyesi. FEHİM KÖYLÜ]
// Öğrenci Adı: [SAMET TOK]
// Öğrenci Numarası: [1030521081]
// Proje Türü: PROJE ÖDEVİ 
// Açıklama: Flutter ile SQLite tabanlı giriş sistemi, admin paneli ve kullanıcı ekranı içeren mobil uygulama.
// ===========================================================

import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Giriş Sistemi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
