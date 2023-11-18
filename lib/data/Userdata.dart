class UserData {
  final int cedula;
  final String nombre;
  final String apellido;
  final int edad;
  final String correo;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String priority;
  final String genero;
  final String pago;
  final int moneda;
  bool isClomplete;
  UserData(
    this.cedula,
    this.nombre,
    this.apellido,
    this.edad,
    this.correo,
    this.startDate,
    this.dueDate,
    this.priority,
    this.genero,
    this.pago, 
    this.moneda,{
    this.isClomplete = false,
  });
}
