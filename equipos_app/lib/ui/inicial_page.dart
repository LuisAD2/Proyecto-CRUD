import 'package:equipos_app/models/mensaje.dart';
import 'package:equipos_app/models/peticion.dart';
import 'package:equipos_app/ui/modificar_equipo.dart';
import 'package:equipos_app/ui/registrar_equipo.dart';
import 'package:flutter/material.dart';
import 'package:equipos_app/models/equipo.dart';

class InicialPage extends StatefulWidget {
  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {

  /*List<Equipo> equipos = [
    Equipo(nombre:'America', liga:'Mexico'),
    Equipo(nombre:'PSG', liga:'Francia'),
    Equipo(nombre:'Barcelona', liga:'España'),
    Equipo(nombre:'Bayer Munich',liga: 'Alemania')
  ];*/ //creamos una lista de equipos de prueba

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipos de Futbol"),
        centerTitle: true,
      ),
      body: obtenerEquipos(context, listaEquipos()),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrarEquipo()))
          .then((newEquipo){
              setState((){
                //equipos.add(newEquipo);
                //se muestra mensaje despues de agregar un equipo a la lista
                mensaje(context, newEquipo.nombre + " se ha guardado!!");
              });
          });
        },
        tooltip: "Agregar Equipo",
        child: Icon(Icons.add),
      ),
    );
  }

  //Widget en el que se obtiene la lista de Equipos guardados por el metodo equipoLista
  Widget obtenerEquipos(BuildContext context, Future<List<Equipo>> futureEquipo){
    return FutureBuilder(
      future: futureEquipo,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          //en espera de una respuesta
          case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator()
          );
          //conexion establecida pero con error
          case ConnectionState.done:
          if(snapshot.hasError){
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              )
            );
          }
          return (snapshot.data != null) ?
            equipoLista(snapshot.data):
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Text("No hay Datos"),
              ),
            );
          default: 
           return Text('Favor de recargar la pantalla..!');
        }
      },
    );
  }

  //Se guardan en una lista los objetos de tipo Equipo
  Widget equipoLista(List<Equipo> equipos){
    return ListView.builder(//mostraremos los equipos en forma de lista
        itemCount: equipos.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: () {
              //Evento para modificar
              Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (_)=> ModificarEquipo(equipos[index])))
                .then((newEquipo){
                    setState((){
                      mensaje(context, newEquipo.nombre + " se ha modificado!!");
                    }
                  );
                }
              );
            },
            onLongPress: (){
              //evento creado para eliminar un equipo
              remueveEquipo(context, equipos[index]);
            },
            title: Text(equipos[index].nombre),
            subtitle: Text(equipos[index].liga),
            leading: CircleAvatar(
              child: Text(equipos[index].nombre.substring(0,1)),
            ),
          );
        },
      );
  }

  remueveEquipo(BuildContext context, Equipo equipo){
    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Eliminar Equipo"),
        content: Text("¿Desea eliminar a " + equipo.nombre + "?"),
        actions: [
          //boton para confirmar que desea eliminar
          TextButton(
            onPressed: (){
              eliminarEquipo(equipo.id).then((value){
                if(value.id != ''){
                  setState(() {});
                  Navigator.pop(context);
                }
              });
            },
            child: Text("Eliminar", style: TextStyle(
              color: Colors.red
            )),
          ),
          //Boton para cancelar eliminar
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text("Cancelar", 
            style: TextStyle(color: Colors.indigo)
            )
          )
        ],
      )
    );
  }

}


