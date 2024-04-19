import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todolist/view/Dashboard/Dashboard.dart';
import 'package:todolist/view/Dashboard/EditData.dart';

String? id_klinik;
String? loc;

class DetailTodo extends StatefulWidget {
  const DetailTodo({
    this.list,
  });
  final list;

  @override
  _DetailTodoState createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  TextEditingController keterangan = TextEditingController();
  List<dynamic> pilihjenis = [
    {
      "title": "Activity",
      "id": "T",
    },
    {
      "title": "Birthday",
      "id": "H",
    },
    {
      "title": "Task",
      "id": "D",
    },
  ];
  String? bagian_jenis;

  DateTime currentDateStart = new DateTime.now();
  var datatglawal;
  var tgl_awal_ymd;

  // var now = new DateTime.now();
  Future<void> buka_tgl_awal(BuildContext context) async {
    final DateTime? pilih_tgl_awal = await showDatePicker(
      context: context,
      initialDate: currentDateStart,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (pilih_tgl_awal != null && pilih_tgl_awal != currentDateStart) {
      setState(() {
        datatglawal = DateFormat('dd-MM-yyyy').format(pilih_tgl_awal);
        tgl_awal_ymd = DateFormat('yyyy-MM-dd').format(pilih_tgl_awal);
      });
    }
  }

  DateTime currentDateEnd = new DateTime.now();

  Future Hapus() async {
    final urls = Uri.parse(
        'https://masyooga.000webhostapp.com/API/delete.php'); // Ganti dengan URL endpoint API Anda

    try {
      var request = http.MultipartRequest('POST', urls);
      request.fields.addAll({
        "todolist_id": widget.list["todolist_id"],
      });

      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // Jika insert berhasil
        print(responseData); // Output response dari server
        print('Data inserted successfully!');

        _showFeedbackDialog(context, " Berhasil ");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName('/'),
        );

        _showFeedbackDialog(context, " Berhasil ");
        // Tambahkan tindakan yang diinginkan setelah data berhasil diinsert
      } else {
        // Jika insert gagal
        print('Failed to insert data.');
        _showFeedbackDialog(context, " Gagal ");

        print(responseData);
        // Tambahkan tindakan yang diinginkan jika gagal melakukan insert
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _showFeedbackDialog(BuildContext context, String ket) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ket,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 36,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.18,
                        ),
                      ),
                      Text(
                        "Membuat Aktivitas",
                        style: TextStyle(
                          color: Color(0xff141414),
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.06,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(dialogContext);

                  // Tutup dialog
                },
                child: Container(
                  width: 229,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blue,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    bagian_jenis = widget.list["jenis"];
    keterangan.text = widget.list["title"];
    String dateString =
        widget.list["tanggal"] as String; // Anggap ini adalah string tanggal
    DateTime date = DateTime.parse(dateString);
    datatglawal = DateFormat('dd-MM-yyyy').format(date);

    super.initState();
  }

  MediaQueryData? queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData!.copyWith(textScaleFactor: 1.0),
      child: Container(
        height: 560,
        child: Column(
          children: [
            //Locate Your City
            Container(
              alignment: Alignment.center,
              child: Text(
                "Cek Todo",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "medium",
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Text(
                          "Tanggal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.07,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          TextFormField(
                            enabled: false,
                            onChanged: (_) {},
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14),
                              labelText: datatglawal == null
                                  ? "Masukan Tanggal"
                                  : datatglawal?.toString(),
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "medium",
                                  color: datatglawal == null
                                      ? const Color.fromARGB(255, 85, 85, 85)
                                      : Colors.black),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 8,
                            top: 5,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month)),
                          )
                        ],
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 15),
                    child: Row(
                      children: [
                        Text(
                          "Activity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.07,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Gender
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffbfbfbf))),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text(
                            "Pilih Kegiatan mu",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "medium",
                                color: Colors.grey),
                          ),
                          value: bagian_jenis,
                          items: pilihjenis == null
                              ? []
                              : pilihjenis?.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      item['title'] ?? "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "medium",
                                          color: Colors.black),
                                    ),
                                    value: item['id'] ?? "",
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              bagian_jenis = value as String?;
                              print(bagian_jenis);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          "Description",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.07,
                          ),
                        ),
                        Text(
                          "*",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.07,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 318,
                      height: 104,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xff020438),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        maxLines: 4,
                        controller: keterangan,
                        // Jumlah baris yang ingin ditampilkan
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),

                  //
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //Select
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Colors.red,
                      height: 44,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Hapus();
                        Navigator.pop(context, loc);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                      highlightElevation: 0,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blue[900],
                      height: 44,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pop(context, loc);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditData(
                                    list: widget.list,
                                  )),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                      highlightElevation: 0,
                      child: Container(
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
