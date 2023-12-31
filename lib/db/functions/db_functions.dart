import 'package:sqf_sample/db/model/data_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:hive/hive.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');
  // final _id = await studentDB.add(value);
  // value.id = _id;
  _db.rawInsert('INSERT INTO student (name,age) VALUES (?,?)',[value.name, value.age]);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');

  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentListNotifier.value.clear();
  _values.forEach((map) {
   final student = StudentModel.fromMap(map);
   studentListNotifier.value.add(student);
   studentListNotifier.notifyListeners();
  });
  
  // studentListNotifier.value.addAll(studentDB.values);

}

// Future<void> deleteStudent(StudentModel id) async{
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   await studentDB.delete(id);
//   getAllStudents();
//   // studentDB.delete(id);
// }
