import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../home/domain/models/tasbih_model.dart';
import '../domain/models/read_tasbihs.dart';

class TasbihController extends GetxController implements GetxService {

  List<Tasbih>? _tasbihs = [];
  List<Tasbih>? get tasbihs => _tasbihs;


  List<ReadTasbih>? _readTasbihs = [];
  List<ReadTasbih>? get readTasbihs => _readTasbihs;
  late Database db;
  bool _isDbInitialized = false;


  int _currentCount = 0;
  int get currentCount => _currentCount;


  int _currentRound = 0;
  int get currentRound => _currentRound;


  int _currentTasbihId = 0;
  int get currentTasbihId => _currentTasbihId;

  int _currentTasbihTarget = 0;
  int get currentTasbihTarget => _currentTasbihTarget;

  Future<void> increament() async {

    _currentCount++;
    if(currentTasbihTarget ==_currentCount){
      _currentCount = 0;
      _currentRound++;

      updateReadTasbihRound(_currentTasbihId,_currentRound);

    }
    updateReadTasbihCount(_currentTasbihId,_currentCount);
      update();
  }

  Future<void> reset({int? tasbihId}) async {

    print("farukh------");
    print(tasbihId);
    print("farukh------");

    _currentCount = 0;
    _currentRound = 0;
    updateReadTasbihRound(tasbihId ?? _currentTasbihId,0);
    updateReadTasbihCount(tasbihId ?? _currentTasbihId,0);
    loadReadTasbihs();

    update();
  }

  Future<void> loadInitialTasbihData(ReadTasbih readTasbih) async {
     _currentCount = readTasbih.count;
     _currentRound = readTasbih.round;
     _currentTasbihId = readTasbih.id ?? 0;
     _currentTasbihTarget = readTasbih.target ?? 0;
     update();
  }



  Future<void> initDb() async {
    if (_isDbInitialized) return;

    final Directory tempDir = await getTemporaryDirectory();
    final String path = join(tempDir.path, 'tasbih_temp.db');

    db = await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        // Create tasbihs table
        await db.execute('''
        CREATE TABLE tasbihs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          language TEXT,
          added_by TEXT,
          user_id INTEGER,
          status INTEGER,
          created_at TEXT,
          updated_at TEXT
        )
      ''');

        // ✅ Create read_tasbihs table
        await db.execute('''
        CREATE TABLE read_tasbihs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          tasbih_id INTEGER NOT NULL,
          count INTEGER NOT NULL,
          round INTEGER NOT NULL,
          target INTEGER NOT NULL,
          status INTEGER,
          insert_id INTEGER,
          created_at TEXT,
          updated_at TEXT,
          tasbih TEXT
        )
      ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {

      }
    );

    _isDbInitialized = true;
  }
  Future<void> syncFromTasbihList(List<Tasbih> remoteTasbihList) async {
    await initDb(); // ✅ FIXED: Now it will wait for db to be initialized
    print(remoteTasbihList.length);

    final existing = await db.query('tasbihs');
    final Set<int> localIds = existing.map((e) => e['id'] as int).toSet();

    final batch = db.batch();
    int newCount = 0;

    for (Tasbih tasbih in remoteTasbihList) {
      if (tasbih.id != null && !localIds.contains(tasbih.id)) {
        batch.insert(
          'tasbihs',
          tasbih.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        newCount++;
      }
    }

    if (newCount > 0) {
      await batch.commit(noResult: true);
    } else {
    }
    // await loadTasbihs(); // Update in-memory list
  }

  Future<void> loadTasbihs() async {
    final data = await db.query('tasbihs');
    _tasbihs = data.map((e) => Tasbih.fromJson(e)).toList();
    update();
  }
  Future<void> loadReadTasbihs() async {
    await initDb(); // Ensure DB is ready

    final data = await db.query('read_tasbihs');

    List<ReadTasbih> list = [];

    for (var row in data) {
      // Fetch the linked tasbih
      final tasbihId = row['tasbih_id'];
      final tasbihData = await db.query(
        'tasbihs',
        where: 'id = ?',
        whereArgs: [tasbihId],
        limit: 1,
      );

      final tasbih = tasbihData.isNotEmpty
          ? Tasbih.fromJson(tasbihData.first)
          : null;

      list.add(
        ReadTasbih.fromJson(row)..tasbih = tasbih,
      );
    }

    _readTasbihs = list;
    update();
  }






  Future<void> addReadTasbih(ReadTasbih readTasbih) async {
    await initDb(); // Ensure DB is initialized
    print("zain------");
    print(readTasbih.tasbih_id);

    print("zain------");

    await db.insert(
      'read_tasbihs',
      readTasbih.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await loadReadTasbihs();
  }

  Future<void> updateReadTasbihCount(int id, int newCount) async {
    await initDb();

    await db.update(
      'read_tasbihs',
      {'count': newCount, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Tasbih?> getTasbihById(int id) async {
    await initDb();

    final List<Map<String, dynamic>> result = await db.query(
      'tasbihs',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Tasbih.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> updateReadTasbihRound(int id, int newRound) async {
    await initDb();

    await db.update(
      'read_tasbihs',
      {'round': newRound, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteReadTasbih(int id) async {
    await initDb();

    await db.delete(
      'read_tasbihs',
      where: 'id = ?',
      whereArgs: [id],
    );

    await loadReadTasbihs(); // Refresh in-memory list
  }

  Future<void> deleteTasbih(int id) async {
    await initDb();

    await db.delete(
      'tasbihs',
      where: 'id = ?',
      whereArgs: [id],
    );

    await loadReadTasbihs(); // Refresh in-memory list
  }


}
