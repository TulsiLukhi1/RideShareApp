import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
  int count = 0;

  @override
  void initState() {
    super.initState();
    print(
        "-------------------------inside showride screen-------------------------------");
    user = _auth.currentUser;
    uid = user?.uid;
    from = widget.from;
    to = widget.to;
    searchRide(uid, from, to);
  }

  List<Map<String, dynamic>> dataList = [];
  Future<List<Map<String, dynamic>>> searchRide(
      String? uid, String from, String to) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("ShareRideInfo");
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("UserInfo");

    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;

    Map<dynamic, dynamic>? ridesData = snapshot.value as Map<dynamic, dynamic>?;

    if (ridesData != null) {
      print("inside if");
      print("------ridesData");
      print(ridesData);
      ridesData.forEach((key, value) async {
        String rideFrom = value['from'];
        String rideTo = value['to'];

        Query uquery = userRef.orderByChild("id").equalTo(value['id']);

        DatabaseEvent uEvent = await userRef.once();
        DataSnapshot udataSnapshot = uEvent.snapshot;

        if (udataSnapshot.value != null) {
          Map<dynamic, dynamic>? userData =
              udataSnapshot.value as Map<dynamic, dynamic>?;
          String name = '';
          String profession = '';
          String title = '';

          if (userData != null && userData.entries.isNotEmpty) {
            MapEntry<dynamic, dynamic> entry = userData.entries.first;
            name = entry.value['name'];
            profession = entry.value['profession'];
            title = entry.value['title'];
          }

          List<String> cities = [
            'surat',
            'kosamba',
            'ankleshwar',
            'bharuch',
            'karjan',
            'vadodara',
            'vasad',
            'anand',
            'nadiad',
            'mahemdabad',
            'ahemdabad'
          ];

          int fromIndex = cities.indexOf(from.toLowerCase().trim());
          int toIndex = cities.indexOf(to.toLowerCase().trim());
          int rideFromIndex = cities.indexOf(rideFrom.toLowerCase().trim());
          int rideToIndex = cities.indexOf(rideTo.toLowerCase().trim());
          print(from.toLowerCase());
          print(to.toLowerCase());
          print(rideFrom.toLowerCase());
          print(rideTo.toLowerCase());
          print(fromIndex);
          print(toIndex);
          print(rideFromIndex);
          print(rideToIndex);
          if (fromIndex != -1 &&
              toIndex != -1 &&
              rideFromIndex != -1 &&
              rideToIndex != -1 &&
              fromIndex < toIndex &&
              rideFromIndex <= fromIndex &&
              rideToIndex >= toIndex) {
            setState(() {
              dataList.add({
                "from": rideFrom,
                "to": rideTo,
                "date": value['date'],
                "time": value['time'],
                "name": name,
                "profession": profession,
                "title": title,
              });
            });
          }
        }
      });
    } else {
      print('No data found');
    }

    return dataList;
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
        body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Container(
              // padding: EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                // border: Border(bottom: BorderSide(color: Colors.black)),
                boxShadow: [
                  // BoxShadow(
                  //   color: Color.fromARGB(255, 208, 208, 208),
                  //   blurRadius: 2.0, // soften the shadow
                  //   spreadRadius: 5.0, //extend the shadow
                  //   offset: Offset(
                  //     5.0, // Move to right 5  horizontally
                  //     5.0, // Move to bottom 5 Vertically
                  //   ),
                  // )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    //here there will be user photo
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    //here there will be user photo
                    child: Text(dataList[index]['name'][0]),
                  ),
                  title: Text(
                    '${dataList[index]['name']} - ${dataList[index]['profession']} ',
                    // snapshot.data?[index]['Name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From: ${dataList[index]['from']},To: ${dataList[index]['to']}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${dataList[index]['date']} ${dataList[index]['org']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chat_outlined,
                    color: Colors.grey[600],
                  ),
                  onTap: () {
                    // handle item tap
                  },
                ),
              ),
            );
          },
        ));
  }
}
