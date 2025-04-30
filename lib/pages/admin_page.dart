import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAdding = false;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final users = await DatabaseHelper().getAllUsers();
    setState(() => _users = users);
  }

  void _addUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isAdding = true);

      await DatabaseHelper().addUser(
        _usernameController.text,
        _passwordController.text,
      );

      setState(() {
        _isAdding = false;
        _usernameController.clear();
        _passwordController.clear();
      });

      _loadUsers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kullanıcı eklendi")),
      );
    }
  }

  void _deleteUser(int id) async {
    await DatabaseHelper().deleteUser(id);
    _loadUsers();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Kullanıcı silindi")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Paneli"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/eru_logo.png', width: 100),
            SizedBox(height: 10),
            Text(
              "Erciyes Üniversitesi\nAdmin Paneli",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration:
                        InputDecoration(labelText: 'Yeni Kullanıcı Adı'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Gerekli' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Şifre'),
                    obscureText: true,
                    validator: (value) => value != null && value.length < 6
                        ? 'En az 6 karakter'
                        : null,
                  ),
                  SizedBox(height: 10),
                  _isAdding
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _addUser,
                          child: Text("Kullanıcı Ekle"),
                        )
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              "Mevcut Kullanıcılar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ..._users.map((user) {
              return ListTile(
                title: Text(user['username']),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteUser(user['id']),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
