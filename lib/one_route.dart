import "package:dio/dio.dart";
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = [];
  final dio = new Dio();
  @override
  void initState() {
    this._getMoreData(page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Fake people"),
      //   backgroundColor: Colors.green,
      // ),
      body: Container(
        child: _buildList(),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: scrollUp,
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void scrollUp(){
    final double start = 0;
    setState(() {
      _sc.animateTo(0.0, duration: Duration(seconds: 1), curve: Curves.easeIn);
    });
    print("올라간다!!");
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return new ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                users[index]['picture']['large'],
              ),
            ),
            title: Text((users[index]['name']['first'])),
            subtitle: Text((users[index]['email'])),
            trailing: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute()));
              },
              child: Text(
                "상세보기",
                textAlign: TextAlign.end,
              ),
              color: Colors.green[100],
            ),
          );
        }
      },
      controller: _sc,
    );
  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = "https://randomuser.me/api/?page=" +
          index.toString() +
          "&results=20&seed=abc";
      print(url);
      final response = await dio.get(url);
      List tList = [];
      for (int i = 0; i < response.data['results'].length; i++) {
        tList.add(response.data['results'][i]);
      }

      setState(() {
        isLoading = false;
        users.addAll(tList);
        page++;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("돌아가기!!"),
        ),
      ),
    );
  }
}