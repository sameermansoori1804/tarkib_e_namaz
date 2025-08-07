import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TasbihScreen extends StatefulWidget {
  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  late Database db;
  List<Map<String, dynamic>> tasbihs = [];

  final List<String> predefinedZikr = [
    'SubhanAllah',
    'Alhamdulillah',
    'Allahu Akbar',
    'La ilaha illallah',
    'Astaghfirullah'
  ];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    final Directory tempDir = await getTemporaryDirectory();
    final String path = join(tempDir.path, 'tasbih_temp.db');

    db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasbihs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            count INTEGER,
            target INTEGER
          )
        ''');
      },
    );

    loadTasbihs();
  }

  Future<void> loadTasbihs() async {
    final data = await db.query('tasbihs');
    setState(() {
      tasbihs = data;
    });
  }

  Future<void> addTasbih(String name, int target) async {
    await db.insert('tasbihs', {
      'name': name,
      'count': 0,
      'target': target,
    });
    loadTasbihs();
  }

  Future<void> incrementCount(int id, int current) async {
    await db.update(
      'tasbihs',
      {'count': current + 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasbihs();
  }

  Future<void> resetCount(int id) async {
    await db.update(
      'tasbihs',
      {'count': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasbihs();
  }

  Future<void> deleteTasbih(int id) async {
    await db.delete(
      'tasbihs',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasbihs();
  }

  void showAddDialog(BuildContext context) {
    String? selectedZikr = predefinedZikr.first;
    TextEditingController targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add New Tasbih'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedZikr,
              decoration: InputDecoration(labelText: 'Select Zikr'),
              items: predefinedZikr.map((zikr) {
                return DropdownMenuItem(
                  value: zikr,
                  child: Text(zikr),
                );
              }).toList(),
              onChanged: (val) {
                selectedZikr = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target Count (optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedZikr != null) {
                int target = int.tryParse(targetController.text) ?? 0;
                addTasbih(selectedZikr!, target);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbih Counter'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: tasbihs.isEmpty
                  ? Center(child: Text('No Tasbihs yet. Tap + to add one.'))
                  : ListView.builder(
                itemCount: tasbihs.length,
                itemBuilder: (context, index) {
                  final item = tasbihs[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(
                        'Count: ${item['count']}'
                            '${item['target'] != null && item['target'] > 0 ? ' / ${item['target']}' : ''}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => incrementCount(item['id'], item['count']),
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () => resetCount(item['id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTasbih(item['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showAddDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
