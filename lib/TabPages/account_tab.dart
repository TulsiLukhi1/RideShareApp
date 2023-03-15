import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/loginscreen.dart';
import '../Screen/updateprofile.dart';
import '../Utills/utills.dart';

class AccountTabScreen extends StatefulWidget {
  const AccountTabScreen({super.key});

  @override
  State<AccountTabScreen> createState() => _AccountTabScreenState();
}

class _AccountTabScreenState extends State<AccountTabScreen> {
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  void signout() {
    setState(() {
      isLoading = true;
    });
    auth.signOut().then((value) {
      setState(() {
        isLoading = false;
      });

      Utills().toastSuccessMessage("Successfully Loged out!");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage()));
    }).catchError((error) {
      Utills().toastFaiureMessage(error.message);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const UpdateProfileScreen()));
        },
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(26, 10, 0.0, 0.0),
                      child: Text(
                        "Not Provided",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  signout();
                },
                child: const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
