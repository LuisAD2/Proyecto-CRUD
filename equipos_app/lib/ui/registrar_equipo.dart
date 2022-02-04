//import 'dart:ffi';
import 'package:equipos_app/models/equipo.dart';
import 'package:equipos_app/models/peticion.dart';
import 'package:equipos_app/models/texto_caja.dart';
import 'package:flutter/material.dart';
//Clase para registrar los equipos

class RegistrarEquipo extends StatefulWidget {
  @override
  State<RegistrarEquipo> createState() => _RegistrarEquipoState();
}

class _RegistrarEquipoState extends State<RegistrarEquipo> {

  //Creamos un controlador para cada caja de texto
  late TextEditingController controllerNombre;
  late TextEditingController controllerLiga;

  @override
  void initState() {
    // TODO: implement initState
    controllerNombre = new TextEditingController(); //inicializamos los controladores
    controllerLiga = new TextEditingController(); 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Equipo"),
      ),
      body: ListView(
        children:[
          //llamamos a la clase TextoCaja para que se muestren las cajas de Texto
          TextoCaja(controllerNombre, "Nombre"),
          TextoCaja(controllerLiga, "Liga"),

          //creamos un boton para guardar el equipo
          ElevatedButton(
            onPressed: (){
            String nombre = controllerNombre.text;
            String liga = controllerLiga.text;
            //validamos que los campos no se encuentren vacios
            if(nombre.isNotEmpty && liga.isNotEmpty){
              Equipo eq = new Equipo(nombre: nombre, liga: liga);
               agregarEquipo(eq).then((value) {
                 if(value.id != null){
                   Navigator.pop(context, value);
                 }else{
                   AlertDialog(
                     content: Text("Fallo al registar")
                   );
                 }
              });
            }
          }, 
          child: Text("Guardar Equipo")
          )
        ],
      ),
    );
  }
}