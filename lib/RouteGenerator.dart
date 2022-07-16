import 'package:flutter/material.dart';
import 'package:my_workout/views/cadastro/cadastro-view.dart';
import 'package:my_workout/views/configuracao/configuracao-view.dart';
import 'package:my_workout/views/home/home-view.dart';
import 'package:my_workout/views/login/login-view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case "/cadastro":
        return MaterialPageRoute(
          builder: (_) => const CadastroView(),
        );
      case "/configuracoes":
        return MaterialPageRoute(
          builder: (_) => const ConfiguracaoView(),
        );

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tela não encontrada!"),
          ),
          body: const Center(
            child: const Text("Tela não encontrada!"),
          ),
        );
      },
    );
  }
}
