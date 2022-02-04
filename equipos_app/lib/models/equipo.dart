class Equipo{
  var id; 
  var nombre;
  var liga;

  Equipo({this.id, this.nombre, this.liga});

  //mapear JSON de equipos
  factory Equipo.fromJson(Map<String, dynamic>json){
    return Equipo(
      id: json['id'],
      nombre: json['nombre'],
      liga: json['liga']
    );
  }
}