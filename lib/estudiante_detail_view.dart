import 'package:flutter/material.dart';
import 'estudiante.dart';
import 'estudiante_database.dart';

class StudentDetailView extends StatefulWidget {
  final Estudiante? student;

  const StudentDetailView({Key? key, this.student}) : super(key: key);

  @override
  _StudentDetailViewState createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _carreraController;
  late TextEditingController _fechaIngresoController;
  late TextEditingController _edadController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.student?.nombre ?? '');
    _carreraController = TextEditingController(text: widget.student?.carrera ?? '');
    _fechaIngresoController = TextEditingController(
      text: widget.student != null ? widget.student!.fechaIngreso.toIso8601String().split('T').first : '',
    );
    _edadController = TextEditingController(text: widget.student?.edad.toString() ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _carreraController.dispose();
    _fechaIngresoController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  Future<void> _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final db = EstudianteDatabase.instance;
      final student = Estudiante(
        id: widget.student?.id,
        nombre: _nombreController.text,
        carrera: _carreraController.text,
        fechaIngreso: DateTime.parse(_fechaIngresoController.text),
        edad: int.parse(_edadController.text),
      );

      if (widget.student == null) {
        await db.create(student);
      } else {
        await db.update(student);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Agregar Estudiante' : 'Editar Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carreraController,
                decoration: InputDecoration(labelText: 'Carrera'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una carrera';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaIngresoController,
                decoration: InputDecoration(labelText: 'Fecha de Ingreso (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una fecha de ingreso';
                  }
                  // Ensure the date is in correct format
                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return 'Formato de fecha no válido. Use YYYY-MM-DD';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edadController,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la edad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
