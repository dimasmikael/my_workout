import 'package:cloud_firestore/cloud_firestore.dart';

class ExercicioModel {
  String? id;
  String? nomeExercicio;
  String? categoria;
  String? repeticao;

  List<String>? fotos;

  ExercicioModel({id,  nomeExercicio, categoria,  repeticao,  fotos});

  // ExercicioModel.fromDocumentSnapshot(DocumentSnapshot doc){
  //
  //
  //
  //   this.id = doc.id;
  //   this.nomeExercicio = doc.data().toString().contains('nomeExercicio') ?doc.get('nomeExercicio'):'';
  //   this.categoria =doc.data().toString().contains('categoria') ?doc.get('categoria'):'';
  //   this.repeticao     = doc.data().toString().contains('repeticao') ?doc.get('repeticao'):'';
  //   this.fotos  = List<String>.from(doc.data().toString().contains('fotos') ?doc.get('fotos '):'');
  //
  // }

  factory ExercicioModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ExercicioModel(
      id: doc['id'],
      nomeExercicio: doc['nomeExercicio'],
      categoria: doc['categoria'],
      repeticao: doc['repeticao'],
      fotos: doc['fotos'],

    );
  }

  ExercicioModel.gerarId(){
    var  db = FirebaseFirestore.instance;
    CollectionReference exercicios = db.collection("meus_exercicios");
    id = exercicios.doc().id;

    fotos = [];
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "nomeExercicio" : this.nomeExercicio,
      "categoria" : this.categoria,
      "repeticao" : this.repeticao,
      "fotos" : this.fotos,
    };

    return map;

  }

  // List<String> get fotos => _fotos!;
  //
  // set fotos(List<String> value) {
  //   _fotos = value;
  // }
  //
  // String get categoria => _categoria!;
  //
  // set categoria(String value) {
  //   _categoria = value;
  // }
  //
  // String get nomeExercicio => _nomeExercicio!;
  //
  // set nomeExercicio(String value) {
  //   _nomeExercicio = value;
  // }
  //
  // String get id => _id!;
  //
  // set id(String value) {
  //   _id = value;
  // }
  //
  // String get repeticao => _repeticao!;
  //
  // set repeticao(String value) {
  //   _repeticao = value;
  // }
}
