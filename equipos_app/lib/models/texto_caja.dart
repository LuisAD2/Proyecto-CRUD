import 'package:flutter/material.dart';

class TextoCaja extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  TextoCaja(this._controller, this._label); //Pasamos los controladores como parametros

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: this._controller,
        decoration: InputDecoration(
          filled: true,
          labelText: this._label,
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: (){
              _controller.clear();
            },
          )
        ),
      ),
    );
  }
}