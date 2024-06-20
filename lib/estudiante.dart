class EstudianteFields {
  static final List<String> values = [
    id, nombre, carrera, fechaIngreso, edad
  ];

  static final String id = 'id';
  static final String nombre = 'nombre';
  static final String carrera = 'carrera';
  static final String fechaIngreso = 'fechaIngreso';
  static final String edad = 'edad';
}

class Estudiante {
  final int? id;
  final String nombre;
  final String carrera;
  final DateTime fechaIngreso;
  final int edad;

  Estudiante({
    this.id,
    required this.nombre,
    required this.carrera,
    required this.fechaIngreso,
    required this.edad,
  });

  Estudiante copy({
    int? id,
    String? nombre,
    String? carrera,
    DateTime? fechaIngreso,
    int? edad,
  }) =>
      Estudiante(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        carrera: carrera ?? this.carrera,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        edad: edad ?? this.edad,
      );

  Map<String, dynamic> toMap() {
    return {
      EstudianteFields.id: id,
      EstudianteFields.nombre: nombre,
      EstudianteFields.carrera: carrera,
      EstudianteFields.fechaIngreso: fechaIngreso.toIso8601String(),
      EstudianteFields.edad: edad,
    };
  }

  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map[EstudianteFields.id],
      nombre: map[EstudianteFields.nombre],
      carrera: map[EstudianteFields.carrera],
      fechaIngreso: DateTime.parse(map[EstudianteFields.fechaIngreso]),
      edad: map[EstudianteFields.edad],
    );
  }
}
