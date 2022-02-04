import 'dart:convert';
import 'package:equipos_app/models/equipo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//clase en la cual estan los metodos para realizar peticiones http al servidor


Future<List<Equipo>> listaEquipos() async{
  final response = 
  //metodo http.get para obtener o recuperar los datos de nuestro servidor
  await http.get(Uri.parse('https://equipos-a1f73-default-rtdb.firebaseio.com/api.json'));

  return compute(decodeJson, response.body);
}

List<Equipo> decodeJson(String responseBody){
  //metodo para convertir el body de respuesta a un JSON
  final myJson = json.decode(responseBody);

  //se convirte el JSON a un objeto de la clase Equipo y se retorna(Lista de equipos)
  return myJson['equipos'].map<Equipo>((json) => Equipo.fromJson(json)).toList();
}

mapEquipo(Equipo equipo, bool mapId){
  Map datos;
  //Para guardar no es necesario enviar el id del objeto
  if(mapId){
    datos = {
      'nombre': '${equipo.nombre}',
      'liga': '${equipo.liga}',
    };
    //Cuando modificamos mandamos el id del objeto equipo
  }else{
    datos = {
      'id': '${equipo.id}',
      'nombre': '${equipo.nombre}',
      'liga': '${equipo.liga}',
    };
  }
  return datos;
}

Future<Equipo> agregarEquipo(Equipo equipo) async{
  var url = Uri.parse('https://equipos-a1f73-default-rtdb.firebaseio.com/api/equipos.json');
  var _body = json.encode(mapEquipo(equipo, false));

  //metodo http.post para agregar a nuestro servidor
  var response = await http.post(url,
  headers: {'Content-Type':'application/json; charset=UTF-8'},
  body: _body
  );

  //respuesta con status de codigo 200 correcto
  if(response.statusCode==200){
    return Equipo.fromJson(jsonDecode(response.body)['equipo']);
  }
  else{
    throw Exception("Error al registrar al equipo");
  }
}

Future<Equipo> modificarEquipo(Equipo equipo) async{
  var url = Uri.parse('https://equipos-a1f73-default-rtdb.firebaseio.com/api/equipos/0.json/');
  var _body = json.encode(mapEquipo(equipo, true));

  //metodo http.put para modificar un equipo
  var response = await http.put(url,
  headers: {'Content-Type':'application/json; charset=UTF-8'},
  body: _body
  );

  //respuesta con status de codigo 200 correcto
  if(response.statusCode==200){
    return Equipo.fromJson(jsonDecode(response.body)['equipo']);
  }
  else{
    throw Exception("Error al modificar al equipo");
  }
}

Future<Equipo> eliminarEquipo(String equipoId) async{
  final response = await http.delete(Uri.parse('https://equipos-a1f73-default-rtdb.firebaseio.com/api/equipos.json/$equipoId'),
   headers: {'Content-Type':'application/json; charset=UTF-8'},
  );

  //respuesta con status de codigo 200 correcto
  if(response.statusCode==200){
    return Equipo.fromJson(jsonDecode(response.body)['equipo']);
  }
  else{
    throw Exception("Error al eliminar al equipo");
  }

}

