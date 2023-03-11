import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../TabPages/account_tab.dart';
import '../TabPages/home_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClick(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [HomeTabScreen(), AccountTabScreen()],
        ),
        bottomNavigationBar: GNav(gap: 8, tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.account_balance,
            text: 'Organization',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ]));
  }
}

// bottomNavigationBar: BottomNavigationBar(
//         items:const [
//           BottomNavigationBarItem(
              
//               icon: Icon(Icons.home),
//               label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
//         ],
//         unselectedItemColor: Color.fromARGB(255, 203, 188, 188),
//         selectedItemColor: Color.fromARGB(255, 100, 145, 236),
//         backgroundColor: Colors.white,
//         type: BottomNavigationBarType.fixed,
//         selectedLabelStyle: const TextStyle(fontSize: 14),
//         showUnselectedLabels: true,
//         currentIndex: selectedIndex,
//         onTap: onItemClick,
//       ),
