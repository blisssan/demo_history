import 'package:flutter/material.dart';
import 'package:sembast_demo/db/history_dao.dart';
import 'package:sembast_demo/history_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  saveInput(int value) {
    HistoryDao.instance.insertBooks(<String, dynamic>{
      'value': value,
      'insertedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Entry Page"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                onPressed: () {
                  saveInput(1);
                },
                child: Text(
                  "Save 1",
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  saveInput(0);
                },
                child: Text(
                  "Save 0",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryList()));
                },
                child: Text(
                  "History",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
