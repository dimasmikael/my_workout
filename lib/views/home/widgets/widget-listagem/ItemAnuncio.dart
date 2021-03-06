import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_workout/models/exercicio-model.dart';


class ItemAnuncio extends StatelessWidget {

  ExercicioModel exercicio;
  VoidCallback? onTapItem;
  VoidCallback? onPressedRemover;

  ItemAnuncio({
    required this.exercicio,
    this.onTapItem,
    this.onPressedRemover
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[

            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                exercicio.fotos![0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                     exercicio?.nomeExercicio ??"",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("R\$ ${exercicio?.repeticao ??""} "),
                  ],),
              ),
            ),
            if( this.onPressedRemover != null ) Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: this.onPressedRemover,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
            )
            //botao remover

          ],),
        ),
      ),
    );
  }
}
