import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'loans.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE loans(id INTEGER PRIMARY KEY, name TEXT, total REAL, startDate TEXT, duration INTEGER)'
      );
      await db.execute(
        'CREATE TABLE payments(id INTEGER PRIMARY KEY, loanId INTEGER, amount REAL, date TEXT)'
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;

  MyApp({required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Tracker',
      home: Scaffold(body: Center(child: Text('Loan Tracker App'))),
    );
  }
}
