import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:e_carnisa/car_bookingdb/database_helper.dart'; // Sesuaikan dengan path database_helper.dart Anda

class Sewa extends StatefulWidget {
  final String username;

  Sewa({required this.username});

  @override
  _SewaState createState() => _SewaState();
}

class _SewaState extends State<Sewa> {
  late Future<List<Map<String, dynamic>>> _carBookings;

  @override
  void initState() {
    super.initState();
    _carBookings = _fetchCarBookings(widget.username);
  }

  Future<List<Map<String, dynamic>>> _fetchCarBookings(String username) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.rawQuery('SELECT * FROM car_bookings WHERE username = ?', [username]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sewa",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: _carBookings,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found for ${widget.username}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return _buildCarBookingCard(snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCarBookingCard(Map<String, dynamic> carBooking) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand: ${carBooking['brand']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Model: ${carBooking['model']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sewa: ${carBooking['sewa']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Harga: ${carBooking['harga']}',
                    style: TextStyle(fontSize: 14),
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
