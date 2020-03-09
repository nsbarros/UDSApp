import 'package:flutter/material.dart';
import 'package:mobile_sidebar/mobile_sidebar.dart';
import 'package:uds_app/app/pages/Pauta/pauta_list_finish_view.dart';
import 'package:uds_app/app/pages/Pauta/pauta_list_open_view.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  int index = 0;
  bool searching = false;
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
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
          return FancyTitle(
            title: Text("My Logo"),
            logo: FlutterLogo(),
          );
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
            child: Text("Sign In"),
            onPressed: () {
              if (mounted)
                setState(() {
                  _loggedIn = true;
                });
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
            builder: (context) => NewScreen(
              color: Colors.lightBlue,
              name: 'Red Screen',
            ),
          ),
        ],
      ),
    );
  }
}

class FancyTitle extends StatelessWidget {
  const FancyTitle({
    Key key,
    @required this.title,
    this.logo,
  }) : super(key: key);

  final Widget title;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    if (logo == null) {
      return logo;
    }
    return Row(
      children: <Widget>[
        logo,
        Container(width: 4.0),
        title,
      ],
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({
    Key key,
    @required this.color,
    @required this.name,
  }) : super(key: key);

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: RaisedButton.icon(
          icon: Icon(Icons.arrow_right),
          label: Text("Push to Screen"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: NewScreen(color: color, name: name),
              ),
            ));
          },
        ),
      ),
    );
  }
}
