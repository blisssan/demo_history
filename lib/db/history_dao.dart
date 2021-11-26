import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/data_base.dart';

class HistoryDao {
  static final HistoryDao _singleton = HistoryDao._();

  static HistoryDao get instance => _singleton;

  HistoryDao._();

  static const String folderName = "History";
  final _historyFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertBooks(Map<String, dynamic> data) async {
    await _historyFolder.add(await _db, data);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final finder = Finder(
      sortOrders: [SortOrder('insertedAt', false)],
    ); // descending order
    final recordSnapshot = await _historyFolder.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value);
      data['id'] = snapshot.key;
      return data;
    }).toList();
  }

  Future delete(id) async {
    return await _historyFolder.record(id).delete(await _db);
  }
}
