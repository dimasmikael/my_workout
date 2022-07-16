
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_workout/models/exercicio-model.dart';
import 'package:my_workout/util/BotaoCustomizado.dart';
import 'package:my_workout/util/InputCustomizado.dart';
import 'package:validadores/validadores.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({Key? key}) : super(key: key);

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  ExercicioModel? _exercicio;
  late  BuildContext _dialogContext;

  final List<XFile> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropCategorias = [];
  final _formKey = GlobalKey<FormState>();
  //

  String? _itemSelecionadoCategoria;
  _selecionarImagemGaleria() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);

    if( imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada );
      });
    }

  }

  _abrirDialog(BuildContext context){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Salvando anúncio...")
              ],),
          );
        }
    );

  }

  _salvarAnuncio() async {


_abrirDialog(context);

    //Upload imagens no Storage
    await _uploadImagens();

    print("lista imagens: ${_exercicio?.fotos.toString()}");


    //Salvar anuncio no Firestore
    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser!;
    String? idUsuarioLogado = usuarioLogado?.uid;

    var db = FirebaseFirestore.instance;
    db.collection("meus_exercicios")
        .doc( idUsuarioLogado )
        .collection("exercicios")
        .doc( _exercicio?.id )
        .set( _exercicio!.toMap()).then((_) {
      Navigator.pop(context);

      Navigator.pop(context);
    }) ; }


  Future _uploadImagens() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for( var imagem in _listaImagens ){

      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo = pastaRaiz
          .child("meus_exercicios")
          .child( _exercicio?.id ??'' )
          .child( nomeImagem );

      UploadTask uploadTask = arquivo.putFile(File( imagem.path));
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      _exercicio?.fotos!.add(url);

    }

  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();

    _exercicio = ExercicioModel();
  }

  _carregarItensDropdown(){

    //Categorias
    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Peito"), value: "peito",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Costas"), value: "costas",)
    );



    // //Estados
    // for( var estado in Estados.listaEstadosAbrv ){
    //   _listaItensDropEstados.add(
    //       DropdownMenuItem(child: Text(estado), value: estado,)
    //   );
    // }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Novo exercicio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: ( imagens ){
                    if( imagens!.length == 0 ){
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state){
                    return Column(children: <Widget>[
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _listaImagens.length + 1, //3
                            itemBuilder: (context, indice){
                              if( indice == _listaImagens.length ){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      _selecionarImagemGaleria();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100],
                                          ),
                                          Text(
                                            "Adicionar",
                                            style: TextStyle(
                                                color: Colors.grey[100]
                                            ),
                                          )
                                        ],),
                                    ),
                                  ),
                                );
                              }

                              if( _listaImagens.length > 0 ){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                            Image.file(
                                            File(
                                             _listaImagens![indice].path,
                                            ),
                                            cacheHeight: 700,
                                            cacheWidth: 700,
                                            fit: BoxFit.contain,
                                          ),

                                                FlatButton(
                                                  child: Text("Excluir"),
                                                  textColor: Colors.red,
                                                  onPressed: (){
                                                    setState(() {
                                                      _listaImagens.removeAt(indice);
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                )
                                              ],),
                                          )
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(
                                        File(  _listaImagens[indice].path)


                                      ),
                                      child: Container(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.delete, color: Colors.red,),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();

                            }
                        ),
                      ),
                      if( state.hasError )
                        Container(
                          child: Text(
                            "[${state.errorText}]",
                            style: TextStyle(
                                color: Colors.red, fontSize: 14
                            ),
                          ),
                        )
                    ],);
                  },
                ),
                Row(children: <Widget>[
                  // Expanded(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8),
                  //     child: DropdownButtonFormField(
                  //       value: _itemSelecionadoEstado,
                  //       hint: Text("Estados"),
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 20
                  //       ),
                  //       items: _listaItensDropEstados,
                  //       validator: (valor){
                  //         return Validador()
                  //             .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                  //             .valido(valor);
                  //       },
                  //       onChanged: (valor){
                  //         setState(() {
                  //           _itemSelecionadoEstado = valor;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        onSaved: (String? categoria){
                          _exercicio?.categoria = categoria!;
                        },
                        value: _itemSelecionadoCategoria,
                        hint: Text("Categorias"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        items: _listaItensDropCategorias,
                        validator: (String? valor){
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                              .valido(valor);
                        },
                        onChanged: (String?  valor){
                          setState(() {
                            _itemSelecionadoCategoria = valor!;
                          });
                        },
                      ),
                    ),
                  ),
                ],),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: InputCustomizado(
                    onSaved: (String? exercicio){
                      _exercicio?.nomeExercicio = exercicio!;
                    },
                    hint: "Exercicio",
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(valor);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    onSaved: (String? repeticao){
                      _exercicio?.repeticao  =repeticao!;
                    },
                    hint: "QTD repeticao",
                    type: TextInputType.number,

                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(valor);
                    },
                  ),
                ),

                BotaoCustomizado(
                  texto: "Cadastrar exercicio",
                  onPressed: (){
                    if( _formKey.currentState!.validate() ){
                      //salva campos
                      _formKey.currentState!.save();

                      //salvar anuncio
                      _salvarAnuncio();
                    }
                  },
                ),
            ],),
          ),
        ),
      ),
    );
  }
}
