import 'package:flutter/material.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset( 
            'assets/images/logo_monitor_page.png',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Monitoring',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(Icons.notifications_none_outlined, size: 30),
              onTap: () {
                print('notifikasi ditekan');
              },
            ),
          ),
        ],
      ),
      body: Center(child: Text('Monitoring Page')),
    );
  }
}
