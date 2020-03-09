import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/Pauta/pauta_finish_controller.dart';
import 'package:uds_app/data/repositories/data_pautas_repository.dart';

class ListFinish extends View{

  @override
  State<StatefulWidget> createState() {
    return _ListFinishState();
  }
}

class _ListFinishState extends ViewState<ListFinish, PautaFinishController> {
  _ListFinishState() : super(PautaFinishController(DataPautaRepository()));

  @override
  Future<void> initState(){
    super.initState();
    controller.getListFinishPautas();
  }

  @override
  Widget buildPage() {

    return Scaffold(
      key:
      globalKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: controller.listFinish != null && controller.listFinish.length > 0 ? ListView.builder(
          itemCount: controller.listFinish.length != null ? controller.listFinish.length : 0,
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
                          subtitle: Text("${controller.listFinish[index].titulo}"),
                        ),
                        ListTile(
                          title: Text("Description"),
                          subtitle: Text("${controller.listFinish[index].descricao}"),
                        ),
                        ListTile(
                          title: Text("Autor"),
                          subtitle: Text("${controller.listFinish[index].autor}"),
                        ),
                        InkWell(
                          // When the user taps the button, show a snackbar.
                          onTap: () {
                            controller.openPauta(controller.listFinish[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Card(child: ListTile(title: Text('Open'), leading: Icon(Icons.check),)),
                          ),
                        )
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${controller.listFinish[index].titulo} - ${controller.listFinish[index].descricao.substring(0, controller.listFinish[index].descricao.length - 2)}..",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: controller.listFinish[index].isExpanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  controller.listFinish[index].isExpanded =
                  !controller.listFinish[index].isExpanded;
                });
              },
            );
          },
        ) : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Please wait, loading information ..."),
            ],
          ),
        ),
      ),
    );
  }
}