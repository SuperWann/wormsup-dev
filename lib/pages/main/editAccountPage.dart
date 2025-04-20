import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wormsup_dev/pages/main/accountPage.dart';
import 'package:wormsup_dev/pages/widgets/button.dart';
import 'package:wormsup_dev/pages/widgets/input_form.dart';

class EditAccountPage extends StatefulWidget {
  final User? currentUser;

  const EditAccountPage({super.key, required this.currentUser});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  // function yang pertama kali dijalankan tanpa dipanggil
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      // Ambil data pengguna dari Firestore
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(currentUser!.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // setState untuk merubah nilai awal controller pada textField
      setState(() {
        _controllerUsername.text = data['username'];
        _controllerEmail.text = data['email'];
      });
    }
  }

  Future<void> _saveChange() async {
    try {
      final newUsername = _controllerUsername.text.trim();
      final newEmail = _controllerEmail.text.trim();

      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(currentUser!.uid).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      final userDataFirestore = _firestore
          .collection("users")
          .doc(currentUser!.uid);

      // Update username langsung ke Firestore
      await userDataFirestore.update({"username": newUsername});

      // Cek dan update email jika berubah
      if (newEmail != currentUser!.email) {
        // Verifikasi email sebelum diperbarui
        await currentUser!.verifyBeforeUpdateEmail(newEmail);
        await userDataFirestore.update({"email": newEmail});

        // Jangan langsung update ke Firestore — tunggu email diverifikasi!
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Cek email untuk verifikasi sebelum email diperbarui",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profil berhasil diperbarui")));
      }

      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memperbarui profil")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profil",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),

                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputFormNoIcon(text: '', controller: _controllerUsername),

                SizedBox(height: 10),

                Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputFormNoIcon(text: '', controller: _controllerEmail),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LongButton(
                text: "Simpan Perubahan",
                color: "#6B4F3B",
                colorText: "#FFFFFF",
                onPressed: () {
                  _saveChange();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
