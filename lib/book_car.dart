import 'package:flutter/material.dart';
import 'package:e_carnisa/constants.dart';
import 'package:e_carnisa/data.dart';
import 'package:e_carnisa/car_bookingdb/database_helper.dart';
import 'package:e_carnisa/widget/get_username.dart';

class BookCar extends StatefulWidget {
  final Car car;
  BookCar({required this.car});
  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  int _currentImage = 0;
  int selectedPeriod = -1;
  String textdatahari = "";
  String textdatausd = "";
  int inputCount = 0; // Track the number of inputs added

  @override
  void initState() {
    super.initState();

    // Set initial values for controllers
    brandController.text = widget.car.brand;
    modelController.text = widget.car.model; // Optionally set other fields
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    brandController.dispose();
    modelController.dispose();
    sewaController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController sewaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.car.images.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Colors.black,
                                      size: 28,
                                    )),
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white,
                                        size: 22,
                                      )),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.black,
                                        size: 22,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.car.model,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.car.brand,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 300, // Fixed height for the PageView
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                _currentImage = page;
                              });
                            },
                            children: widget.car.images.map((path) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Hero(
                                  tag: widget.car.model,
                                  child: Image.asset(
                                    path,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        widget.car.images.length > 1
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildPageIndicator(),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: 110, // Menentukan tinggi ListView
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildPricePerPeriod(
                                    "10", "2jt", selectedPeriod == 0, () {
                                  setState(() {
                                    textdatahari = "10";
                                    textdatausd = "2.000.000";
                                    selectedPeriod = 0;
                                  });
                                }),
                                SizedBox(width: 16),
                                buildPricePerPeriod(
                                    "6", "8ratus", selectedPeriod == 1, () {
                                  setState(() {
                                    textdatahari = "6";
                                    textdatausd = "800.000";
                                    selectedPeriod = 1;
                                  });
                                }),
                                SizedBox(width: 16),
                                buildPricePerPeriod(
                                    "2", "5ratus", selectedPeriod == 2, () {
                                  setState(() {
                                    textdatahari = "1";
                                    textdatausd = "500.000";
                                    selectedPeriod = 2;
                                  });
                                }),
                                SizedBox(width: 16),
                                buildPricePerPeriod(
                                    "1", "4ratus", selectedPeriod == 3, () {
                                  setState(() {
                                    textdatahari = "1";
                                    textdatausd = "400.000";
                                    selectedPeriod = 3;
                                  });
                                }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Text(
                                  "SPECIFICATIONS",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              Container(
                                height: 80,
                                padding: EdgeInsets.only(
                                  top: 8,
                                  left: 16,
                                ),
                                margin: EdgeInsets.only(bottom: 16),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    buildSpecificationCar("Color", "White"),
                                    buildSpecificationCar(
                                        "Gearbox", "Automatic"),
                                    buildSpecificationCar("Seat", "4"),
                                    buildSpecificationCar("Motor", "v10 2.0"),
                                    buildSpecificationCar(
                                        "Speed (0-100)", "3.2 sec"),
                                    buildSpecificationCar(
                                        "Top Speed", "121 mph"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: inputCount >= 1
                    ? MediaQuery.of(context).size.height * 0.6
                    : 0,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, -3), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              // Reset inputCount and close the form
                              inputCount = 0;
                            });
                          },
                          child: Text('Kembali'),
                        ),
                      ),
                      SizedBox(
                          height:
                              24), // Spacing between 'Kembali' button and form fields
                      TextFormField(
                        controller: brandController,
                        decoration: InputDecoration(
                          labelText: 'Brand',
                          hintText: 'Masukkan Brand...',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              16), // Spacing between 'Name' field and 'Email' field
                      TextFormField(
                        controller: modelController,
                        decoration: InputDecoration(
                          labelText: 'Model',
                          hintText: 'Masukkan Model...',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              16), // Spacing between 'Email' field and 'Phone' field
                      TextFormField(
                        controller: sewaController,
                        decoration: InputDecoration(
                          labelText: 'Sewa',
                          hintText: 'Masukkan Sewa...',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                        ),
                      ),

                      SizedBox(
                          height:
                              16), // Spacing between 'Email' field and 'Phone' field
                      TextFormField(
                        controller: hargaController,
                        decoration: InputDecoration(
                          labelText: 'Harga',
                          hintText: 'Masukkan Harga...',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 3, 55, 167),
                                width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              24), // Spacing between 'Phone' field and buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (brandController.text.isEmpty ||
                                  modelController.text.isEmpty ||
                                  sewaController.text.isEmpty ||
                                  hargaController.text.isEmpty) {
                                _showAlertDialog(
                                    'Error', 'Please fill all fields');
                                return;
                              }

                              String username = GetUsername.getUsername();
                              Map<String, dynamic> row = {
                                'username': username,
                                'brand': brandController.text,
                                'model': modelController.text,
                                'sewa': sewaController.text,
                                'harga': hargaController.text,
                              };

                              try {
                                int id = await DatabaseHelper.instance
                                    .insertCarBooking(row);
                                _showAlertDialog('Success',
                                    'Car booking saved successfully');
                              } catch (error) {
                                _showAlertDialog('Error',
                                    'Failed to save car booking. Please try again.');
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textdatahari + " hari",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "RP." + textdatausd,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "per " + textdatahari + " hari",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // Increment inputCount dijumlahkan ketika di click
                  if (textdatausd == "") {
                    _showAlertDialog("Error", "Silahkan pilih harian");
                  } else {
                    inputCount++;
                    sewaController.text = textdatahari + ' hari';
                    hargaController.text = textdatausd;
                    print(textdatahari);
                  }
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Ambil Mobil",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  Widget buildPricePerPeriod(
      String months, String price, bool selected, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150, // Atur lebar sesuai kebutuhan
        height: 110,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: Colors.grey,
            width: selected ? 0 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              months + " hari",
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              price,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "RUPIAH",
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecificationCar(String title, String data) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
