import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'estudiante.dart';

class EstudianteDatabase {
  static final EstudianteDatabase instance = EstudianteDatabase._init();

  static Database? _database;

  EstudianteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('estudiantes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE estudiantes ( 
  id $idType, 
  nombre $textType,
  carrera $textType,
  fechaIngreso $textType,
  edad $integerType
  )
''');
  }

  Future<Estudiante> create(Estudiante estudiante) async {
    final db = await instance.database;

    final id = await db.insert('estudiantes', estudiante.toMap());
    return estudiante.copy(id: id);
  }

  Future<Estudiante> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'estudiantes',
      columns: EstudianteFields.values,
      where: '${EstudianteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Estudiante.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Map<String, dynamic>>> readAll() async {
    final db = await instance.database;

    final result = await db.query('estudiantes');

    return result;
  }

  Future<int> update(Estudiante estudiante) async {
    final db = await instance.database;

    return db.update(
      'estudiantes',
      estudiante.toMap(),
      where: 'id = ?',
      whereArgs: [estudiante.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'estudiantes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
