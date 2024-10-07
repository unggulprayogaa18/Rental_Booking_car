import 'package:e_carnisa/screen/login_signup.dart';
import 'package:e_carnisa/widget/get_email.dart';
import 'package:e_carnisa/widget/get_username.dart';
import 'package:flutter/material.dart';
import 'package:e_carnisa/autenticationdb/database_helper.dart';

class AkunRoom extends StatefulWidget {
  @override
  _AkunRoomState createState() => _AkunRoomState();
}

class _AkunRoomState extends State<AkunRoom> {
  @override
  Widget build(BuildContext context) {
    String username = GetUsername.getUsername();
    String email = GetEmail.getEmail();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Akun Room",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.white, // Background color putih
      body: ListView(
        children: <Widget>[
          // Informasi Akun
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/acura_0.png'), // Ganti dengan path atau URL gambar avatar
            ),
            title: Text("$username"),
            subtitle: Text(
                "$email"), // Ganti dengan email atau informasi tambahan akun
            trailing: Icon(Icons.edit),
            onTap: () {
              // Tambahkan logika jika ingin mengedit informasi akun
            },
          ),
          Divider(),
          // Opsi-opsi lainnya
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting"),
            onTap: () {
              // Navigasi atau aksi saat mengklik Setting
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              // Navigasi atau aksi saat mengklik About
            },
          ),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text("Policy"),
            onTap: () {
              // Navigasi atau aksi saat mengklik Policy
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () {
              // Navigasi atau aksi saat mengklik Exit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginSignupScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
