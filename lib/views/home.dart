import 'package:flutter/material.dart';
import 'package:sql/constants/routes.dart';
import 'package:sql/models/database.dart';
import 'package:sql/models/db_manager.dart';
import 'package:sql/models/dog.dart';
import 'dart:developer';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final AppDatabase? db = await DBManager.instance.database;

    final list = await db!.dogDao.findAllDogs();
    log(list.toString());
    return list;
  }

  _navigateTo(String route) {
    return () {
      Navigator.pushNamed(
        context,
        route,
      ).then((dataChanged) async {
        bool modified = dataChanged as bool;
        // call setstate to reload list on data modified
        if (modified) setState(() {});
      });
    };
  }

  // https://stackoverflow.com/questions/49930180/flutter-render-widget-after-async-call
  //https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
  List<Dog> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _navigateTo(Routes.add_dog),
      ),
      body: FutureBuilder(
          future: dogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
            if (snapshot.hasData) {
              this.data = snapshot.data ?? [];
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: _navigateTo(Routes.add_dog),
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 8),
                    color:
                        index % 2 == 0 ? Colors.green[400] : Colors.green[200],
                    child: Center(
                      child: Text('Perrito ${data[index].name}'),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
//https://flutter.dev/docs/cookbook/gestures/handling-taps
