import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:mobile_sidebar/mobile_sidebar.dart';
import 'package:uds_app/app/pages/Pauta/pauta_list_finish_view.dart';
import 'package:uds_app/app/pages/Pauta/pauta_list_open_view.dart';

import '../../../data/repositories/data_users_repository.dart';
import '../Profile/profile_controller.dart';
import '../Profile/profile_view.dart';


class Welcome extends View{
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends ViewState<Welcome, ProfileController> {

  int index = 0;
  bool searching = false;
  bool _loggedIn = false;

  _WelcomeState() : super(ProfileController(DataUsersRepository()));

  @override
  Widget buildPage() {
    return SafeArea(
      child: Scaffold(
        body: MobileSidebar(
          currentIndex: index,
          onTabChanged: (val) {
            if (mounted)
              setState(() {
                index = val;
              });
          },
          isSearching: searching,
          isSearchChanged: (val) {
            if (mounted)
              setState(() {
                searching = val;
              });
          },
          titleBuilder: (context) {
            return Container(
              width: 40,
                height: 40,
                child: Image(image: AssetImage("images/logo.png"),));
          },
          accountBuilder: (context) {
            if (_loggedIn) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        _loggedIn = false;
                      });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              );
            }
            return FlatButton(
              child: Text("Sign Out"),
              onPressed: () {
                controller.signOut();
              },
            );
          },
          showSearchButton: true,
          tabs: <TabChild>[
            TabChild(
              icon: Icon(Icons.list),
              title: 'List Open',
              builder: (context) => ListOpen(),
            ),
            TabChild(
              icon: Icon(Icons.list),
              title: 'List Close',
              builder: (context) => ListFinish(),
            ),
            TabChild(
              icon: Icon(Icons.person),
              title: 'Profile',
              builder: (context) => Profile(),
            ),
          ],
        ),
      ),
    );
  }
}
