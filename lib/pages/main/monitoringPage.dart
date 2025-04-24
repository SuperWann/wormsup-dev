import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wormsup_dev/pages/main/notifikasi.dart';
import 'package:wormsup_dev/pages/widgets/alert.dart';
import 'package:wormsup_dev/viewModel/login_view_model.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _MonitoringPageState extends State<MonitoringPage> {
  late User? currentUser;
  String? username;
  late bool? controlStatusPerangkat;

  @override
  void initState() {
    super.initState();
    currentUser = LoginViewModel().currUser;
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    if (currentUser != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(currentUser!.uid).get();

      setState(() {
        username = userData['username'];
      });
    }
  }

  List<Widget> tabBar = [Text('Kelembapan'), Text('pH Tanah')];
  final List<Map<String, String>> riwayat = [
    {
      'teks': 'Kelembapan tanah bernilai 25%, Normal.',
      'tanggal': '20 April, 20:53',
    },
    {
      'teks': 'Kelembapan tanah bernilai 26%, Normal.',
      'tanggal': '20 April, 19:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 28%, Normal.',
      'tanggal': '20 April, 18:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 32%, Normal.',
      'tanggal': '20 April, 17:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    {
      'teks': 'Kelembapan tanah bernilai 35%, Normal.',
      'tanggal': '20 April, 16:35',
    },
    // Tambah data lagi jika perlu
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(115),
            child: AppBar(
              leadingWidth: 60,
              leading: Container(
                padding: EdgeInsets.only(left: 0),
                child: Image.asset(
                  'assets/images/logo_monitor_page.png',
                  height: 100, // atau bisa lebih besar
                  fit: BoxFit.contain,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai,',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    username ?? 'Loading...',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  child: Icon(Icons.notifications_none_outlined, size: 30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotifikasiPage(),
                      ),
                    );
                  },
                ),
              ],
              bottom: TabBar(
                tabs: tabBar,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,

                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(41, 107, 79, 59),
                ),
                unselectedLabelStyle: TextStyle(
                  color: Color.fromARGB(172, 107, 79, 59),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
                labelColor: Color(0xFF6B4F3B),
                indicatorColor: Color(0xFF6B4F3B),
                labelPadding: EdgeInsets.all(15),
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream:
                FirebaseFirestore.instance
                    .collection('status_perangkat')
                    .doc('status_perangkat')
                    .snapshots(),
            builder: (context, snapshot) {
              final statusPerangkat = snapshot.data?['status'];

              Future<void> updateStatusPerangkat() async {
                if (statusPerangkat != null) {
                  await _firestore
                      .collection('status_perangkat')
                      .doc('status_perangkat')
                      .update({'status': !statusPerangkat});
                }
              }

              void konfirmasiLogout() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Confirm(
                      message:
                          'Mesin tidak akan melakukan kontrol otomatis untuk menstabilkan kelembapan dan pH tanah saat  perangkat dimatikan.' +
                          '\n' +
                          '\n' +
                          'Apakah Anda yakin ingin mematikan perangkat?',
                      height: 160,
                      onPressed: () async {
                        updateStatusPerangkat();
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }

              if (snapshot.hasData) {
                return Stack(
                  children: [
                    TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.yMMMEd().add_Hm().format(
                                      DateTime.now(),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  WavePercentage(
                                    centerText: '${25}%',
                                    centerTextStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                    ),
                                    size: 200,
                                    currentPercentage: 25,
                                    maxPercentage: 100,
                                    backgroundStrokeWidth: 2,
                                    backgroundColor: Colors.black12,
                                    waveColor: Color(0xFF6F826A),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      bottom: 10,
                                    ),
                                    child: Divider(thickness: 1),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Riwayat',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height:
                                        280, // Sesuaikan tinggi sesuai kebutuhan
                                    child: ListView.builder(
                                      itemCount: riwayat.length,
                                      itemBuilder: (context, index) {
                                        final item = riwayat[index];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item['teks']!,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                item['tanggal']!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.yMMMEd().add_Hm().format(
                                      DateTime.now(),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  CircularPercentage(
                                    centerText: 6.5.toString(),
                                    centerTextStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 50,
                                    ),
                                    percentageStrokeWidth: 10,
                                    size: 200,
                                    currentPercentage: 65,
                                    maxPercentage: 100,
                                    backgroundStrokeWidth: 2,
                                    backgroundColor: Colors.black12,
                                    percentageColor: Color(0xFF6F826A),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      bottom: 10,
                                    ),
                                    child: Divider(thickness: 1),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Riwayat',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height:
                                        280, // Sesuaikan tinggi sesuai kebutuhan
                                    child: ListView.builder(
                                      itemCount: riwayat.length,
                                      itemBuilder: (context, index) {
                                        final item = riwayat[index];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item['teks']!,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                item['tanggal']!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Positioned(
                      bottom: 110,
                      right: 10,

                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: FloatingActionButton(
                          onPressed:
                              statusPerangkat == true
                                  ? konfirmasiLogout
                                  : updateStatusPerangkat,
                          elevation: 0,
                          backgroundColor:
                              statusPerangkat == true
                                  ? Color(0xFF6F826A)
                                  : Color(0xFFCE5355),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            statusPerangkat == true ? 'Hidup' : 'Mati',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
