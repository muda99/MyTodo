import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todolist/view/Dashboard/AddData.dart';
import 'package:todolist/view/Dashboard/DetailTodo.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool _isButtonPressed1 = false;
  bool _isButtonPressed2 = false;
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2, _animation3;

  List? list;

  Future CekData() async {
    final urls = Uri.parse(
        'https://masyooga.000webhostapp.com/API/data.php'); // Ganti dengan URL endpoint API Anda

    try {
      var request = http.MultipartRequest('POST', urls);

      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          list = jsonDecode(responseData);
        });

        print(list);
        // Jika insert berhasil
        print(responseData); // Output response dari server
        print('Data inserted successfully!');

        // Tambahkan tindakan yang diinginkan setelah data berhasil diinsert
      } else {
        list = null;
        // Jika insert gagal

        print(responseData);
        // Tambahkan tindakan yang diinginkan jika gagal melakukan insert
      }
    } catch (error) {
      list = null;
      print('Error: $error');
    }
  }

  String formatTanggal(String tanggalDariDB) {
    // Ubah tanggal dari format yang diperoleh dari database menjadi DateTime
    DateTime dateTime = DateTime.parse(tanggalDariDB);

    // Format tanggal menjadi tanggal dan nama bulan dalam bahasa Inggris
    String tanggalDanBulan = DateFormat.MMMMd('en_US').format(dateTime);

    return tanggalDanBulan;
  }

  Icon _getIconForJenis(String jenis) {
    switch (jenis) {
      case 'T':
        return Icon(
          Icons.check_circle,
          color: Colors.blue,
          size: 30,
        );
      case 'H':
        return Icon(
          Icons.cake,
          color: Colors.blue,
          size: 30,
        );
      case 'D':
        return Icon(
          Icons.description,
          color: Colors.blue,
          size: 30,
        );
      default:
        return Icon(
          Icons.check,
          color: Colors.blue,
          size: 30,
        ); // Replace with your fallback icon
    }
  }

  void locationDialogue(dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Lebar dialog
            height: MediaQuery.of(context).size.height * 0.6, // Tinggi dialog
            child: DetailTodo(list: item),
          ),
        );
      },
    ).then((value) {
      setState(() {
        CekData();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    CekData();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.33, curve: Curves.easeIn),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.66, curve: Curves.easeIn),
      ),
    );

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.66, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  MediaQueryData? queryData;
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData!.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // Drawer untuk sedbar
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Muhammad Yoga P'),
                accountEmail: Text('masmudapradana@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Tambah Aktivitas'),
                onTap: () {
                  // Tambahkan aksi yang diinginkan saat item di sedbar ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddData()),
                  );
                },
              ),
              ListTile(
                title: Text('Close App'),
                onTap: () {
                  // Tambahkan aksi yang diinginkan saat item di sedbar ditekan
                  SystemNavigator.pop();
                },
              ),
              // Tambahkan item sedbar lainnya di sini
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Apps Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => Container(
                            width: 52,
                            height: 37,
                            child: IconButton(
                              icon: Icon(Icons.menu, size: 30),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'My Todo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Palanquin Dark',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 35,
                          height: 40,
                          child: Stack(
                            children: [
                              // Icon notifikasi
                              Positioned.fill(
                                child: Icon(Icons.notifications, size: 30),
                              ),

                              // Tanda merah notifikasi
                              Positioned(
                                left: 4,
                                bottom: 6,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await CekData();
                  },
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.green[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 26,
                                        height: 26,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF378A50),
                                          shape: CircleBorder(),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons
                                                .check, // Replace with your desired icon
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Tambahkan jarak antara ikon dan teks
                                      Expanded(
                                        child: Text(
                                          'Complete Flutter UI App Challenge and upload it on Github',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Tambahkan jarak antara teks dan waktu
                                      Text(
                                        '1h 25 m',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (list != null)
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Remaining Tasks ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Palanquin Dark',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "(${list!.length.toString()})",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Palanquin Dark',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Widget lain di sini jika diperlukan
                          ],
                        ),
                      if (list == null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 100.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Your to-do list is empty!',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Add tasks to keep track of your activities.',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (list != null)
                        for (var item in list!)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    8.0), // Add rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.3), // Shadow color
                                    offset: Offset(4.0, 4.0), // Shadow offset
                                    blurRadius: 8.0, // Shadow blur radius
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  locationDialogue(item);
                                },
                                leading: Container(
                                  width: 26,
                                  height: 26,
                                  child: Center(
                                    child:
                                        // Get icon based on "jenis"
                                        _getIconForJenis(item['jenis']),
                                    // Replace with your desired icon
                                  ),
                                ),
                                title: Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                trailing: Text(
                                  formatTanggal(item['tanggal']),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),

                      // Display your other widgets from the "otherWidgets" key in the map
                    ],
                  ),
                ),
              ),

              //
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddData()),
            );
          },
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
