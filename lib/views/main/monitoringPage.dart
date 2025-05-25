import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wormsup_dev/services/firebase_auth_service.dart';
import 'package:wormsup_dev/services/firebase_perangkat_service.dart';
import 'package:wormsup_dev/views/main/notifikasi.dart';
import 'package:wormsup_dev/views/widgets/alert.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _MonitoringPageState extends State<MonitoringPage> {
  User? currentUser;
  String? username;
  bool? controlStatusPerangkat;
  final AuthService authService = AuthService();
  final PerangkatService perangkatService = PerangkatService();

  @override
  void initState() {
    super.initState();
    currentUser = authService.currUser;
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

  void konfirmasiMatikanPerangkat(bool statusPerangkat) {
    showDialog(
      context: context,
      builder: (context) {
        return Confirm(
          message:
              'Perangkat IoT tidak akan melakukan kontrol otomatis untuk menstabilkan kelembapan dan monitoring pH tanah saat  perangkat dimatikan.' +
              '\n' +
              '\n' +
              'Apakah Anda yakin ingin mematikan perangkat?',
          height: 160,
          onPressed: () async {
            perangkatService.updateStatusPerangkat(statusPerangkat);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void konfirmasiHidupkanPerangkat(bool statusPerangkat) {
    showDialog(
      context: context,
      builder: (context) {
        return Confirm(
          message:
              'Pastikan perangkat IoT terhubung dengan daya listrik dan WiFi rumah Anda, agar dapat monitoring secara berkala',
          height: 110,
          onPressed: () async {
            perangkatService.updateStatusPerangkat(statusPerangkat);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  List<Widget> tabBar = [Text('Kelembapan'), Text('pH')];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(115),
            child: AppBar(
              leadingWidth: 60,
              backgroundColor: Colors.white,
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
            stream: PerangkatService().streamStatusPerangkat(),
            builder: (context, snapshot) {
              final statusPerangkat = snapshot.data?['status'];

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
                                  SizedBox(height: 80),
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
                                  StreamBuilder<DocumentSnapshot>(
                                    stream:
                                        FirebaseFirestore.instance
                                            .collection('perangkat')
                                            .doc('esp32_1')
                                            .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        debugPrint(
                                          'Terjadi error: ${snapshot.error}',
                                        ); // tampilkan log di debug console
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        debugPrint('Data tidak ditemukan');
                                        return Center(
                                          child:
                                              CircularProgressIndicator(), // tampilkan loading juga saat data kosong
                                        );
                                      }

                                      final dataKelembapan =
                                          snapshot.data?['kelembapan'];

                                      return Center(
                                        child: WavePercentage(
                                          centerText:
                                              statusPerangkat == true
                                                  ? '$dataKelembapan%'
                                                  : '0',
                                          centerTextStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 40,
                                            color: Colors.black,
                                          ),
                                          size: 250,
                                          currentPercentage:
                                              statusPerangkat == true
                                                  ? double.parse(
                                                    dataKelembapan.toString(),
                                                  )
                                                  : 0,
                                          maxPercentage: 100,
                                          backgroundStrokeWidth: 2,
                                          backgroundColor: Colors.black12,
                                          waveColor: Color(0xFF6F826A),
                                        ),
                                      );
                                    },
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
                                  SizedBox(height: 80),
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
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: perangkatService.streamDataSensor(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        debugPrint(
                                          'Terjadi error: ${snapshot.error}',
                                        ); // tampilkan log di debug console
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        debugPrint('Data tidak ditemukan');
                                        return Center(
                                          child:
                                              CircularProgressIndicator(), // tampilkan loading juga saat data kosong
                                        );
                                      }

                                      final dataPh = snapshot.data?['pH'];

                                      return CircularPercentage(
                                        centerText:
                                            statusPerangkat == true
                                                ? dataPh.toString()
                                                : '0',
                                        centerTextStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                        ),
                                        percentageStrokeWidth: 10,
                                        size: 250,
                                        currentPercentage:
                                            statusPerangkat == true
                                                ? dataPh
                                                : 0,
                                        maxPercentage: 14,
                                        backgroundStrokeWidth: 2,
                                        backgroundColor: Colors.black12,
                                        percentageColor: Color(0xFF6F826A),
                                      );
                                    },
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
                              () =>
                                  statusPerangkat == true
                                      ? konfirmasiMatikanPerangkat(
                                        statusPerangkat,
                                      )
                                      : konfirmasiHidupkanPerangkat(
                                        statusPerangkat,
                                      ),
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
