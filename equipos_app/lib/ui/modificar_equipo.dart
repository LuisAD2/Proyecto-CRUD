import 'package:equipos_app/models/equipo.dart';
import 'package:equipos_app/models/peticion.dart';
import 'package:equipos_app/models/texto_caja.dart';
import 'package:flutter/material.dart';
//clase para modificar un equipo que ha sido agregado

class ModificarEquipo extends StatefulWidget {
 final Equipo _equipo; //necesitamos los datos del equipo para mostrarlos y modificarlos
 ModificarEquipo(this._equipo);

  @override
  State<ModificarEquipo> createState() => _ModificarEquipoState();
}

class _ModificarEquipoState extends State<ModificarEquipo> {

  late TextEditingController controllerNombre;
  late TextEditingController controllerLiga;
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    Equipo eq = widget._equipo;
    id = eq.id;
    controllerNombre = new TextEditingController(text: eq.nombre); //inicializamos los controladores con los datos de cada equipo
    controllerLiga = new TextEditingController(text: eq.liga); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Equipo"),
      ),
      body: ListView(
        children: [
          //llamamos a la clase TextoCaja para que se muestren las cajas de Texto
          TextoCaja(controllerNombre, "Nombre"),
          TextoCaja(controllerLiga, "Liga"),

          //creamos un boton para modificar el equipo
          ElevatedButton(
            onPressed: (){
            String nombre = controllerNombre.text;
            String liga = controllerLiga.text;

            if(nombre.isNotEmpty && liga.isNotEmpty){
              Equipo eq = new Equipo(id: id, nombre: nombre, liga: liga);
               modificarEquipo(eq).then((value) {
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
          child: Text("Actualizar Equipo")
          )
        ],
      ),
    );
  }
}