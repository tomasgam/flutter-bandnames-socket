import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands =[
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Guns and Roses', votes: 3),
    Band(id: '3', name: 'Muse', votes: 5),
    Band(id: '4', name: 'Nirvana', votes: 4),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle( color: Colors.black87) ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (  context,  i) => _bandTile(bands[i])      
     ),
     floatingActionButton: FloatingActionButton(
      elevation: 1,
      onPressed: addNewBand,
      child: const Icon(Icons.add)
     ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white) ),
        )

      ),
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text( band.name.substring(0,2)),
            ),
            title: Text( band.name),
            trailing: Text('${ band.votes}', style: TextStyle( fontSize: 20) ),
            onTap: () {
              print(band.name);
            },
          ),
    );
  }

  addNewBand(){
    
    final textController = new TextEditingController();
    
    if ( Platform.isAndroid ) {
      // Android
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList( textController.text )
              )
            ],
          );
        },
      );
  }

  showCupertinoDialog(
    context: context, 
    builder: ( _ ) {
      return CupertinoAlertDialog(
        title: Text('New band name:'),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions:  [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Dismiss'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    }
  );
}

void addBandToList(String name){
  if ( name.length >1 ){
    this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
    setState((){});
  }

  

  Navigator.pop(context);

}
}