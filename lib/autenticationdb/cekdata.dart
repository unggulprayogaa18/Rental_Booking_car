import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:e_carnisa/autenticationdb/database_helper.dart';

// Fungsi untuk membuka database dan menjalankan kueri
void checkData() async {
  // Buka atau buat database SQLite
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'app.db'); // Sesuaikan nama database dengan yang digunakan
  Database database = await openDatabase(path);

  try {
    // Jalankan kueri untuk mengambil semua data dari tabel users
    List<Map<String, dynamic>> users = await database.rawQuery('SELECT * FROM users');

    // Tampilkan data
    users.forEach((user) {
      print('User: ${user['username']}, Email: ${user['email']}, Password: ${user['password']}, Status: ${user['status']}');
    });
  } catch (error) {
    print('Error: $error');
  } finally {
    // Tutup koneksi database setelah selesai menggunakan
    await database.close();
  }
}

/// untuk test status
/// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// void checkData() async {
//   // Buka atau buat database SQLite
//   var databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, 'app.db'); // Sesuaikan nama database dengan yang digunakan
//   Database database = await openDatabase(path);

//   try {
//     // Hapus tabel users jika sudah ada
//     await database.execute('DROP TABLE IF EXISTS users');

//     // Buat kembali tabel users
//     await database.execute('''
//       CREATE TABLE users (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         username TEXT NOT NULL,
//         email TEXT NOT NULL,
//         password TEXT NOT NULL,
//         status TEXT DEFAULT 'user'
//       )
//     ''');

//     print('Tabel users berhasil dihapus dan dibuat kembali.');

//   } catch (error) {
//     print('Error: $error');
//   } finally {
//     // Tutup koneksi database setelah selesai menggunakan
//     await database.close();
//   }
// }

