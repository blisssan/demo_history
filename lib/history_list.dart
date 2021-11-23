import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sembast_demo/db/history_dao.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books List"),
      ),
      body: Container(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                !snapshot.hasData) {
              print("data: ${snapshot.data}");
              return Container(color: Colors.red);
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> historyEntry = snapshot.data[index];
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                      historyEntry['insertedAt']);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
                  return snapshot.data.length == null
                      ? CircularProgressIndicator()
                      : ListTile(
                          title: Text('Test Value: ${historyEntry['value']}'),
                          trailing: Text('$formattedDate'),
                          onTap: () {},
                        );
                });
          },
          future: HistoryDao.instance.getAll(),
        ),
      ),
    );
  }
}
