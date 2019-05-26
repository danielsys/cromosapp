import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {

  List _data = await getJSON();

  String _body = _data[0]['name'];

  runApp(

    new MaterialApp(
      home: new Scaffold(
        appBar: AppBar( title: Text("JSON"), ),
        body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext context, posicao) {
                return Column (
                  children: <Widget>[
                    Divider(height:5.0),
                    ListTile(
                      title: Text(_data[posicao]['email'].toString().toLowerCase()),
                      subtitle: Text(_data[posicao]['body'].toString().substring(0,40) + "..."),
                      onTap: () => debugPrint("clicked..."),
                    ),
                  ]
                );
              },
          ),
        ),
      ),
    ),
    );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON',
      home: new Scaffold(
        appBar: AppBar(
          title: Text("JSON"),
        ),
      )
    );
  }
}

Future<List> getJSON() async {
  String url = 'http://jsonplaceholder.typicode.com/comments';

  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Falha ao carregar");
  }

}