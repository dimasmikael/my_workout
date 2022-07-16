import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_workout/models/exercicio-model.dart';
import 'package:my_workout/views/home/widgets/widget-listagem/ItemAnuncio.dart';

class ListagemExerciciosWidget extends StatefulWidget {
  const ListagemExerciciosWidget({Key? key}) : super(key: key);

  @override
  State<ListagemExerciciosWidget> createState() => _ListagemExerciciosWidgetState();
}

class _ListagemExerciciosWidgetState extends State<ListagemExerciciosWidget> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String? _idUsuarioLogado;

  _recuperaDadosUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado =  auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;

  }

  Future<Stream<QuerySnapshot>?>? _adicionarListenerAnuncios() async {

    await _recuperaDadosUsuarioLogado();

   var db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_exercicios")
        .doc( _idUsuarioLogado )
        .collection("exercicios")
        .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });

  }

  _removerAnuncio(String idAnuncio){

    var db = FirebaseFirestore.instance;
    db.collection("meus_anuncios")
        .doc( _idUsuarioLogado )
        .collection("anuncios")
        .doc( idAnuncio )
        .delete();

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerAnuncios();
  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados = Center(
      child: Column(children: <Widget>[
        Text("Carregando exercicios"),
        CircularProgressIndicator()
      ],),
    );

    return     StreamBuilder<QuerySnapshot>(
    stream: _controller.stream,
    builder: (context, snapshot){

    switch( snapshot.connectionState ){
    case ConnectionState.none:
    case ConnectionState.waiting:
    return carregandoDados;
    break;
    case ConnectionState.active:
    case ConnectionState.done:

    //Exibe mensagem de erro
    if(snapshot.hasError)
    return Text("Erro ao carregar os dados!");

    QuerySnapshot? querySnapshot = snapshot.data;
    //DocumentSnapshot? snap = snapshot.data;

    //DocumentSnapshot querySnapshot = snapshot.data as DocumentSnapshot;

    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (_, indice){

    List<DocumentSnapshot>? anuncios = querySnapshot?.docs.toList();
    DocumentSnapshot documentSnapshot = anuncios![indice];
    ExercicioModel exercicio = ExercicioModel.fromDocumentSnapshot(documentSnapshot);

    return ItemAnuncio(
      exercicio: exercicio,
    onPressedRemover: (){
    showDialog(
    context: context,
    builder: (context){
    return AlertDialog(
    title: Text("Confirmar"),
    content: Text("Deseja realmente excluir o anúncio?"),
    actions: <Widget>[

    FlatButton(
    child: Text(
    "Cancelar",
    style: TextStyle(
    color: Colors.white
    ),
    ),
    onPressed: (){
    Navigator.of(context).pop();
    },
    ),

    FlatButton(
    color: Colors.red,
    child: Text(
    "Remover",
    style: TextStyle(
    color: Colors.grey
    ),
    ),
    onPressed: (){
    _removerAnuncio( exercicio?.id ??'' );
    Navigator.of(context).pop();
    },
    ),


    ],
    );
    }
    );
    },
    );
    }
    );

    }

    return Container();

    },
    );
  }
}
