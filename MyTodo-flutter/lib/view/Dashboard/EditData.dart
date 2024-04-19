import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todolist/view/Dashboard/Dashboard.dart';

String? poliid;
String? id_dep;
String? kode_reservasi;
String? namapoli;
String? tglbooking;
String? nama_dokter;
String? id_dokter;
String? id_jam;

// ignore: must_be_immutable
class EditData extends StatefulWidget {
  const EditData({
    this.list,
  });
  final list;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  var tgl_awal_ymd;
  var tgl_akhir_ymd;
  String?
      selectedStartTime; // Variabel untuk menyimpan nilai terpilih dari dropdown jam awal
  String? selectedEndTime;
  String? dp_id;
  String? bagian_jenis;
  String? alber_jenis;
  String? user_nama;
  String? shift_awal;
  String? shift_akhir;
  TextEditingController tanggalawal = TextEditingController();
  TextEditingController tanggalakhir = TextEditingController();
  TextEditingController jamawal = TextEditingController();
  TextEditingController jamakhir = TextEditingController();
  TextEditingController jenisalber = TextEditingController();
  TextEditingController departemen = TextEditingController();
  TextEditingController bagian = TextEditingController();
  DateTime currentDate = new DateTime.now();
  var dateVal;
  var now = new DateTime.now();
  Future<void> openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentDate) {
      setState(() {
        dateVal = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  DateTime currentDateStart = new DateTime.now();
  var datatglawal;
  var tgl_awal;

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
  var datatglakhir;
  var tgl_akhir;

  // var now = new DateTime.now();
  Future<void> buka_tgl_akhir(BuildContext context) async {
    final DateTime? pilih_tgl_akhir = await showDatePicker(
      context: context,
      initialDate: currentDateEnd,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (pilih_tgl_akhir != null && pilih_tgl_akhir != currentDateEnd) {
      setState(() {
        datatglakhir = DateFormat('dd-MM-yyyy').format(pilih_tgl_akhir);
        tgl_akhir_ymd = DateFormat('yyyy-MM-dd').format(pilih_tgl_akhir);
      });
    }
  }

  String? nama_user;
  String? alamat_;
  String? nowa;
  String? id_user = "";
  String? image_profil;
  Widget? indikator;

  ////

  String? selectedHour;
  String? selectedMinute;

  List<String> hours = List.generate(24, (index) => index.toString());
  List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));
  //alber
  List? datajson;

  String? id_absen;
  String? cek_absen;
  String? masuk;
  String? keluar;

  late String tgl;
  String? id_shift;
  String? shift_masuk;
  String? shift_keluar;

  TextEditingController idUser = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  Future _Edit() async {
    final urls = Uri.parse(
        'https://masyooga.000webhostapp.com/API/edit.php'); // Ganti dengan URL endpoint API Anda

    try {
      var request = http.MultipartRequest('POST', urls);
      request.fields.addAll({
        "todolist_id": widget.list["todolist_id"],
        'title': keterangan.text,
        "jenis": bagian_jenis ?? "",
        'tanggal': tgl_awal_ymd,
        'status': "y",
        'id_user': "1",
      });

      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // Jika insert berhasil
        print(responseData); // Output response dari server
        print('Data inserted successfully!');
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
                  // Container(
                  //   width: 63,
                  //   height: 63,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: const Icon(
                  //     Icons.send,
                  //     size: 80,
                  //     color: Color.fromARGB(255, 0, 131, 0),
                  //   ),
                  // ),
                  // const SizedBox(height: 32),
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

  String? jenis;
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

  List? jenis_alber;

  List<dynamic>? jenis_bagian;

// Variabel untuk menyimpan nilai terpilih dari dropdown jam akhir

  List? startTimeList;
  List? endTimeList;
  bool isLoading = false;
  MediaQueryData? queryData;
  @override
  void initState() {
    bagian_jenis = widget.list["jenis"];
    keterangan.text = widget.list["title"];
    tgl_awal_ymd = widget.list["tanggal"];
    String dateString =
        widget.list["tanggal"] as String; // Anggap ini adalah string tanggal
    DateTime date = DateTime.parse(dateString);
    datatglawal = DateFormat('dd-MM-yyyy').format(date);
    // lihatprofil();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MediaQuery(
      data: queryData!.copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            child: Column(
              children: [
                //Appbar
                Container(
                  height: 50,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //back btn
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        start: 5,
                        top: 10,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(Icons.arrow_back_rounded)),
                        ),
                      ),
                      //title
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 10,
                        bottom: 0,
                        start: 0,
                        end: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Edit Todo",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'inter',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
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
                          onTap: () {
                            buka_tgl_awal(context);
                          },
                          child: Stack(
                            children: [
                              TextFormField(
                                enabled: false,
                                onChanged: (_) {
                                  print(tgl_awal);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 14),
                                  labelText: datatglawal == null
                                      ? "Masukan Tanggal"
                                      : datatglawal?.toString(),
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "medium",
                                      color: datatglawal == null
                                          ? const Color.fromARGB(
                                              255, 85, 85, 85)
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
                              border:
                                  Border.all(color: const Color(0xffbfbfbf))),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 5,
            height: 97,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });

                              _Edit().then((_) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            color: Colors.blue,
                            minWidth: 312,
                            height: 50,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Indikator loading
                                Visibility(
                                  visible: isLoading,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                                // Teks tombol
                                Visibility(
                                  visible: !isLoading,
                                  child: const Text(
                                    'Kirim',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
}
