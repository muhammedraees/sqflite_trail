import 'package:sqf_sample/db/functions/db_functions.dart';
import 'package:sqf_sample/screens/widgets/add_student_widget.dart';
import 'package:sqf_sample/screens/widgets/list_student_widget.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          AddStudentWidget(),
          const Expanded(child: ListStudentWidget()),
        ],
      ))
    );
  }
}