import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                    print('notifikasi ditekan');
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
          body: TabBarView(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.yMEd().add_jms().format(DateTime.now()),
                        ),
                        WavePercentage(
                          size: 200,
                          currentPercentage: 50,
                          maxPercentage: 100,
                          backgroundStrokeWidth: 2,
                          backgroundColor: Colors.black12,
                          waveColor: Color(0xFF6F826A),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(thickness: 1),
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
                          DateFormat.yMMMEd().add_Hm().format(DateTime.now()),
                        ),
                        CircularPercentage(
                          percentageStrokeWidth: 10,
                          size: 200,
                          currentPercentage: 50,
                          maxPercentage: 100,
                          backgroundStrokeWidth: 2,
                          backgroundColor: Colors.black12,
                          percentageColor: Color(0xFF6F826A),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(thickness: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
