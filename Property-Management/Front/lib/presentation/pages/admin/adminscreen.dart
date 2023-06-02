
import '../../../application/profile/bloc/profile_bloc.dart';


import '../../../presentation/pages/admin/admin.dart';


import '../../../presentation/pages/user_profile/profile.dart';

import '../../../presentation/routes/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';



class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List pages = [AdminAdd(), UserProfile()];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade100,
          currentIndex: current,
          onTap: (index) {
            setState(() {
              current = index;
            });
          },
          selectedItemColor: Colors.lightBlue,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.apps_outlined)),
            BottomNavigationBarItem(label: "profile", icon: Icon(Icons.person)),
          ]),
    );
  }
}
