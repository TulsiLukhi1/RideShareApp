import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShowRideScreen extends StatefulWidget {
  final String from;
  final String to;

  const ShowRideScreen({super.key, required this.from, required this.to});

  @override
  State<ShowRideScreen> createState() => _ShowRideScreenState();
}

class _ShowRideScreenState extends State<ShowRideScreen> {
  final _auth = FirebaseAuth.instance;
  var from;
  var to;
  User? user;
  var uid;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    uid = user?.uid;
    from = widget.from;
    to = widget.to;
  }

  List<Map<String, dynamic>> data = [];

  Future<List<Map<String, dynamic>>> searchRide(
      String? uid, String from, String to) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("ShareRideInfo");

    Query query = ref.orderByChild("id").equalTo(uid);
    DataSnapshot dataSnapshot = await query.get();

    print(dataSnapshot.value);

    if (dataSnapshot.value != null) {
      (dataSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        var fromValue = value['from'];
        var toValue = value['to'];

        print("-------------------inside searchride");
        print(fromValue);
        print(toValue);

        if (fromValue.toString().toLowerCase().contains(from.toLowerCase()) &&
            toValue.toString().toLowerCase().contains(to.toLowerCase())) {
          print("-----------------inside if");
          data.add({
            "from": fromValue,
            "to": toValue,
            "date": value['date'],
            "time": value['time']
          });
        }
      });
    } else {
      print('No data found');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color.fromARGB(255, 100, 145, 236),
                  Color.fromARGB(255, 69, 204, 231),
                ]),
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Carpool"),
      ),
      body: FutureBuilder(
        future: searchRide(uid, from, to),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 208, 208, 208),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      //here there will be user photo
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      //here there will be user photo
                      child: Text(snapshot.data?[index]['from'][0]),
                    ),
                    title: Text(
                      snapshot.data?[index]['to'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From: ${snapshot.data?[index]['from']}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${snapshot.data?[index]['date']} ${snapshot.data?[index]['time']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[600],
                    ),
                    onTap: () {
                      // handle item tap
                    },
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
