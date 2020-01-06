import 'package:apps_flutter/editdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './editdata.dart';
import 'main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});
  @override
  _DetailState createState() => new _DetailState();
}
  class _DetailState extends State<Detail>{

  void deleteData(){
    var url="http://192.168.8.117/My_Store/deletedata.php";
    http.post(url,body: {
      'id': widget.list[widget.index]['id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Lo yakin pengen hapus datanya '${widget.list[widget.index]['item_name']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("Delete",style: new TextStyle(color: Colors.white)),
          color: Colors.red,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new MyHomePage(),

              )
            );
          }
        ),
        new RaisedButton(
          child: new Text("Cancel",style: new TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: ()=>Navigator.pop(context),
        ),
      ],
    );
    
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['item_name']}")),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text(widget.list[widget.index]['item_name'],style: new TextStyle(fontSize: 20.0),),
                new Text("Code : ${widget.list[widget.index]['item_code']}",style: new TextStyle(fontSize: 18.0),),
                new Text("Harga : ${widget.list[widget.index]['price']}",style: new TextStyle(fontSize: 18.0),),
                new Text("Stock : ${widget.list[widget.index]['stock']}",style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.green,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=> new EditData(list: widget.list, index: widget.index,),
                        )
                      ),
                    ),
                    new RaisedButton(
                        child: new Text("Delete"),
                        color: Colors.red,
                        onPressed: ()=>confirm()
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}