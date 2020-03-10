import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/app/pages/Pauta/Widgets/Loading_widget.dart';
import 'package:UDSApp/app/pages/Profile/profile_controller.dart';
import 'package:UDSApp/data/repositories/data_users_repository.dart';

class Profile extends View{

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }

}

class _ProfileState extends ViewState<Profile, ProfileController> {
  _ProfileState() : super(ProfileController(DataUsersRepository()));

  @override
  Future<void> initState() {
    super.initState();
    controller.getUser();
  }

  @override
  Widget buildPage() {
    return Scaffold(
      key:
      globalKey,
      body: controller.user != null ? Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Nome:"),
              subtitle: Text(controller.user.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text("Email:"),
              subtitle: Text(controller.user.email),
            ),
          ),
        ],
      ) : Loading(),
    );
  }
}