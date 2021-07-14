import "package:bottom_sheet/bottom_sheet.dart";
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'one_route.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Text("Welcome"),
        ),
      );
    });
  }

  int _currentIndex = 0;
  List pages = [
    Home(),
    Home(),
    Home(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    if(_currentIndex == 0){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tabbar_Mission!"),
          ),
          body: Container(
            child: Text("Home"),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,      //item이 4개 이상일 경우 추가
            // onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: "Order"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket),
                  label: "Shopping"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "MyPage"
              )
            ],
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home(),
              ));
            },
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                _settingModalBottomSheet(context);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      );
    }

    else{
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tabbar_Mission!"),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                _settingModalBottomSheet(context);
              },
            ),
          ),

          body: Container(
            child: pages[_currentIndex],
          ),


          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,      //item이 4개 이상일 경우 추가
            // onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: "Order",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket),
                  label: "Shopping"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "MyPage"
              )
            ],
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home(),
              ));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      );
    }
    }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(context: context,
        builder: (BuildContext bc){
      return Container(
        child: new Wrap(
          children: [
            new ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Music'),
              onTap: () => {}
      ),
            new ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () => {},
            ),
            new ListTile(
              leading: new Icon(Icons.play_circle_fill),
              title: new Text('Play'),
              onTap: () => {},
            ),
            new ListTile(
              leading: new Icon(Icons.shop),
              title: new Text('Market'),
              onTap: () => {},
            ),
          ],
        ),
      );
        }
    );
  }
}

