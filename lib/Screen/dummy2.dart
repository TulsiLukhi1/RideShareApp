// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:rideshare/Screen/showrides.dart';

// import '../Widgets/mybutton.dart';

// class RequestRideTab extends StatefulWidget {
//   const RequestRideTab({super.key});

//   @override
//   State<RequestRideTab> createState() => _RequestRideTabState();
// }

// class _RequestRideTabState extends State<RequestRideTab> {
//   final _formKey = GlobalKey<FormState>();
//   final fromController = TextEditingController();
//   final toController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   DatabaseReference shareRideRef =
//       FirebaseDatabase.instance.ref("ShareRideInfo");

//   @override
//   void initState() {
//     super.initState();
//     final User? user = _auth.currentUser;
//     final uid = user?.uid;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     fromController.dispose();
//     toController.dispose();
//   }

//   void seeRides() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (BuildContext context) => ShowRideScreen(
//                 from: fromController.text,
//                 to: toController.text,
//               )));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   style: const TextStyle(fontSize: 14),
//                   controller: fromController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter From field";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                       hintText: 'From',
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       labelStyle: const TextStyle(
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 203, 202, 202)),
//                       prefixIcon: Icon(
//                         Icons.circle,
//                         color: Colors.green.withOpacity(0.4),
//                         size: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               strokeAlign: 60,
//                               color: Color.fromARGB(255, 203, 202, 202)))),
//                 ),
//                 TextFormField(
//                   style: const TextStyle(fontSize: 14),
//                   controller: toController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter To field";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                       hintText: 'To',
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       labelStyle: const TextStyle(
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 203, 202, 202)),
//                       prefixIcon: Icon(
//                         Icons.circle,
//                         color: Colors.red.withOpacity(0.4),
//                         size: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color.fromARGB(255, 203, 202, 202)))),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 MyElevatedButton(
//                   width: 250,
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       seeRides();
//                     }
//                   },
//                   borderRadius: BorderRadius.circular(20),
//                   child: const Text(
//                     'SEARCH RIDE',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, letterSpacing: 1),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//     ;
//   }
// }


// Future<List<Map<String, dynamic>>> searchRide(
//       String? uid, String from, String to) async {
//     DatabaseReference ref = FirebaseDatabase.instance.ref("ShareRideInfo");
//     DatabaseReference userRef = FirebaseDatabase.instance.ref("UserInfo");
//     Query query = ref.orderByChild("id").equalTo(uid);
//     DataSnapshot dataSnapshot = await query.get();
//     print(dataSnapshot.value);
//     if (dataSnapshot.value != null) {
//       (dataSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) async {
//         var id = value['id'];
//         var fromValue = value['from'];
//         var toValue = value['to'];

//         var name;
//         var profession;
//         var title;

//         Query uquery = userRef.orderByChild("id").equalTo(uid);
//         DataSnapshot udataSnapshot = await uquery.get();
//         print(udataSnapshot.value);
//         if (udataSnapshot.value != null) {
//           (udataSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
//             name = value['name'];
//             profession = value['profession'];
//             title = value['title'];
//           });
//         }

//         if (fromValue.toString().toLowerCase().contains(from.toLowerCase()) &&
//             toValue.toString().toLowerCase().contains(to.toLowerCase())) {
//           data.add({
//             "from": fromValue,
//             "to": toValue,
//             "date": value['date'],
//             "time": value['time'],
//             "name": name,
//             "profession": profession,
//             "title": title,
//           });
//         }
//       });
//     } else {
//       print('No data found');
//     }

//     return data;
//   }
