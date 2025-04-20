import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wormsup_dev/pages/auth/authPage.dart';
import 'package:wormsup_dev/viewModel/login_view_model.dart';

import './editAccountPage.dart';
import '../widgets/alert.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

late User? currentUser;
final users = FirebaseFirestore.instance.collectionGroup('users');

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    currentUser = LoginViewModel().currUser;
  }

  void _konfirmasiLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmLogout(message: 'Apakah Anda yakin ingin keluar?');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection("users")
                .doc(currentUser!.uid)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(125, 156, 156, 156),
                      backgroundImage:
                          Image.asset('assets/images/rijal.jpg').image,
                      radius: 80,
                    ),

                    SizedBox(height: 25),

                    Text(
                      userData['username'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),

                    Text(
                      userData['email'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                    ),

                    SizedBox(height: 30),

                    ListTile(
                      title: Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    EditAccountPage(currentUser: currentUser),
                          ),
                        );
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),

                    ListTile(
                      title: Text(
                        "Panduan",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),

                    ListTile(
                      title: Text(
                        "Keluar",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),

                      onTap: () {
                        _konfirmasiLogout();
                      },
                      trailing: Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
