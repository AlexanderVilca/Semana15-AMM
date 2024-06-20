import 'package:crud/estudiante.dart';
import 'package:flutter/material.dart';

class StudentDetailView extends StatefulWidget {
  final Estudiante? student;

  // Constructor que acepta un estudiante opcionalmente
  const StudentDetailView({Key? key, this.student}) : super(key: key);

  @override
  _StudentDetailViewState createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  // Aquí va la lógica para visualizar y editar detalles del estudiante
  // Puedes usar widget.student para acceder al estudiante pasado como parámetro
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Agregar Estudiante' : 'Editar Estudiante'),
      ),
      body: const Center(
        child: Text('Detalles del Estudiante'),
      ),
    );
  }
}
