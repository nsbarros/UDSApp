import 'package:UDSApp/app/pages/Pauta/pauta_insert_controller.dart';
import 'package:UDSApp/data/repositories/data_pautas_repository.dart';
import 'package:UDSApp/domain/entities/pauta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'Widgets/Loading_widget.dart';

class AddPauta extends View{

  final _title = TextEditingController();
  final _description = TextEditingController();
  final _autor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _AddPautaState();
  }

}

class _AddPautaState extends ViewState<AddPauta, AddPautaController> {
  _AddPautaState() : super(AddPautaController(DataPautaRepository()));

  @override
  void initState() {
    super.initState();
    controller.getUser();
  }

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 60,
            left: 40,
            right: 40,
          ),
          child: controller.user != null ? ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: widget._title,
                validator: (value){
                  return _validarForm(value);
                },
                style: new TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget._description,
                keyboardType: TextInputType.text,
                validator: (value){
                  return _validarForm(value);
                },
                style: new TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                initialValue: controller.user != null ? controller.user.name : '',
                keyboardType: TextInputType.text,
                validator: (value){
                  return _validarForm(value);
                },
                style: new TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Autor",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(0, 72, 118, 255),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Add",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Icon(Icons.arrow_forward),
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      controller.add(Pauta('', widget._title.text, widget._description.text, widget._autor.text, 'open'));
                    },
                  ),
                ),
              ),
            ],
          ) : Loading(),
        ),
      ),
    );
  }

  String _validarForm(String value) {
    if(value.isNotEmpty){
     return "Required field";
    }
    return null;
  }
}