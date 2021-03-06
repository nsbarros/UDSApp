import 'package:UDSApp/app/pages/Pauta/pauta_insert_view.dart';
import 'package:UDSApp/app/pages/Pauta/pauta_open_controller.dart';
import 'package:UDSApp/data/repositories/data_pautas_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'Widgets/Loading_widget.dart';
class ListOpen extends View{

  @override
  State<StatefulWidget> createState() {
    return _ListOpenState();
  }
}

class _ListOpenState extends ViewState<ListOpen, PautaOpenController> {
  _ListOpenState() : super(PautaOpenController(DataPautaRepository()));

  @override
  Future<void> initState(){
    super.initState();
    controller.getListPautaOpen();
  }

  @override
  Widget buildPage() {
   return Scaffold(
     key:
     globalKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: controller.listOpen != null && controller.listOpen.length > 0 ? ListView.builder(
          itemCount: controller.listOpen.length != null ? controller.listOpen.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(seconds: 1),
              children: [
                ExpansionPanel(
                  body: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text("Title"),
                          subtitle: Text("${controller.listOpen[index].titulo}"),
                        ),
                        ListTile(
                          title: Text("Description"),
                          subtitle: Text("${controller.listOpen[index].descricao}"),
                        ),
                        ListTile(
                          title: Text("Autor"),
                          subtitle: Text("${controller.listOpen[index].autor}"),
                        ),
                        InkWell(
                          // When the user taps the button, show a snackbar.
                          onTap: () {
                            controller.finishPauta(controller.listOpen[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Card(child: ListTile(title: Text('Finish'), leading: Icon(Icons.check),)),
                          ),
                        )
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${controller.listOpen[index].titulo} - ${controller.listOpen[index].descricao}",
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: controller.listOpen[index].isExpanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  controller.listOpen[index].isExpanded =
                  !controller.listOpen[index].isExpanded;
                });
              },
            );
          },
        ) : Loading(),
      ),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => AddPauta()),
         );
       },
       child: Icon(Icons.add, color: Colors.white,),
       backgroundColor: Colors.blue,
     ),
    );
  }
}