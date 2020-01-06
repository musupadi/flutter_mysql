import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import './Detail.dart';
import './adddata.dart';



void main(){
  runApp(new MaterialApp(
    title: "My Store",
    home: new MyHomePage(),
  ));
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list==null ? 0 : list.length,
      itemBuilder: (context,i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context)=> new Detail(list:list,index: i,)
            )
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['item_name']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Stock : ${list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async{
    final response=await http.get("http://192.168.8.117/My_Store/getData.php");
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: new Text("MY STORE"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (BuildContext context) => new AddData())
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(list: snapshot.data,)
              : new Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }
}


