import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_workout/models/usuario.dart';
import 'package:my_workout/shared/constants/colors.dart';
import 'package:my_workout/util/size-config/size-config.dart';
import 'package:my_workout/views/home/home-view.dart';
import 'package:my_workout/views/login/widgets/background-image-widget.dart';
import 'package:my_workout/views/login/widgets/form-login-widget.dart';
import 'package:my_workout/views/login/widgets/title-subtitle-widget.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController controllerEmail =
      TextEditingController(text: 'teste4@gmail.com');
  final TextEditingController controllerSenha =
      TextEditingController(text: '1234567');

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;

    if (usuarioLogado == null) {
      null;
    } else {
      //Navigator.pushReplacementNamed(context, '/home');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeView()));
    }
  }

  @override
  void initState() {
    super.initState();

// _verificarUsuarioLogado();
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String email = controllerEmail.text;
    String senha = controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if (_cadastrar) {
          //Cadastrar
          _cadastrarUsuario(usuario);
        } else {
          //Logar
          _logarUsuario(usuario);
        }
      } else {
        setState(
          () {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          },
        );
      }
    } else {
      setState(
        () {
          _mensagemErro = "Preencha o E-mail válido";
        },
      );
    }
  }

  Align forgetButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot your password?",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.kThirdColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: const [
                BackGroundImageWidget(),
                TitleSubtileWidget(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLoginWidget(
                    controllerEmail,
                    controllerSenha,
                  ),
                  //  const SizedBox(height: 15),
                  //   forgetButton(),
                  //  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Logar"),
                      Switch(
                        value: _cadastrar,
                        onChanged: (bool valor) {
                          setState(() {
                            _cadastrar = valor;
                            _textoBotao = "Entrar";
                            if (_cadastrar) {
                              _textoBotao = "Cadastrar";
                            }
                          });
                        },
                      ),
                      const Text("Cadastrar"),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _validarCampos();
                          },
                          child: Container(
                            height: SizeConfig.safeBlockVertical! * 10,
                            width: SizeConfig.safeBlockHorizontal! * 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kFirstColor,
                            ),
                            child: Center(
                              child: Text(
                                _textoBotao,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _mensagemErro,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Container(
                        //     height: SizeConfig.safeBlockVertical! * 20,
                        //     width: SizeConfig.safeBlockHorizontal! * 30,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: kThirdColor,
                        //         border:
                        //             Border.all(width: 1, color: kFirstColor)),
                        //     child: const Center(
                        //       child: Text(
                        //         "Sign Up",
                        //         style: TextStyle(
                        //             color: Colors.white, fontSize: 20),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
