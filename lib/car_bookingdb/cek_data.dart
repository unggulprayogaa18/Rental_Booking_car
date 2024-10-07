import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:e_carnisa/autenticationdb/database_helper.dart';

// Fungsi untuk membuka database dan menjalankan kueri
void checkCarBookings() async {
  // Buka atau buat database SQLite
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'e_carnisa.db'); // Sesuaikan nama database dengan yang digunakan
  Database database = await openDatabase(path);

  try {
    // Jalankan kueri untuk mengambil semua data dari tabel car_bookings
    List<Map<String, dynamic>> carBookings = await database.rawQuery('SELECT * FROM car_bookings');

    // Tampilkan data
    carBookings.forEach((booking) {
      print('Username: ${booking['username']}, Brand: ${booking['brand']}, Model: ${booking['model']}, Sewa: ${booking['sewa']}, Harga: ${booking['harga']}');
    });
  } catch (error) {
    print('Error: $error');
  } finally {
    // Tutup koneksi database setelah selesai menggunakan
    await database.close();
  }
}

// // Contoh penggunaan
// void main() async {
//   await DatabaseHelper.instance.database; // Pastikan database telah dibuka sebelum memanggil checkCarBookings
//   await checkCarBookings();
// }
