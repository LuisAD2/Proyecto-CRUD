//Mostrar mensaje en pantalla si se creo un equipo
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mensaje(BuildContext context, String nombre){
  showDialog(context: context, 
  builder: (_) => AlertDialog(
    title: Text("Mensaje"),
    content: Text("¡¡El equipo " + nombre),
  )
  );
}
