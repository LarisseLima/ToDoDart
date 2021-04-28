import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  final _toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Color(0xDDcdb4db),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _toDoController,
                  decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Color(0xDDcdb4db))),
                )),
                RaisedButton(
                  color: Color(0xDDcdb4db),
                  child: Text("Adicione"),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            ),
          )
        ],
      ),
    );

    // ignore: dead_code
    Future<File> _getFile() async {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
    }

    Future<File> _saveData() async {
      String data = json.encode(_toDoList);

      final file = await _getFile();
      return file.writeAsString(data);
    }

    Future<String> _readData() async {
      try {
        final file = await _getFile();

        return file.readAsString();
      } catch (e) {
        return null;
      }
    }
  }
}
