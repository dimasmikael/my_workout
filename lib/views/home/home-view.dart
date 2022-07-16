import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_workout/shared/constants/colors.dart';
import 'package:my_workout/shared/constants/icons.dart';
import 'package:my_workout/views/cadastro/cadastro-view.dart';
import 'package:my_workout/views/configuracao/configuracao-view.dart';
import 'package:my_workout/views/home/widgets/listagem-exercicios-widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();
late   BuildContext _context;

  _getPage(int page) {
    switch (page) {
      case 0:
        return const ListagemExerciciosWidget();
      case 1:
        return Container(color: Colors.blueAccent,);
      case 2:
        return Container(color: Colors.redAccent,);
      case 3:
        return
          ConfiguracaoView();

       // Future.delayed(new Duration(milliseconds: 1500), ()
       //    {
       //     // Navigator.of(context).pushNamed("/configuracoes");
       //      Navigator.push(context, MaterialPageRoute(builder: (_) => ConfiguracaoView()));
       //
       //    });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyWorkout'),
      ),
      drawer: const Drawer(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60,
        items: const <Widget>[
          Icon(AppIcons.dumbell, size: 31, color: Colors.white),
          Icon(Icons.food_bank_rounded, size: 32.5, color: Colors.white),
          Icon(Icons.calculate_rounded, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
          // Icon(Icons.perm_identity, size: 30),
        ],
        color: AppColors.LIGHT_BLACK,
        buttonBackgroundColor: AppColors.LIGHT_BLACK,
        backgroundColor: AppColors.BLACK,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(_page),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.white,
        onPressed: () =>
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Navigator.push(context, MaterialPageRoute(builder: (_) => CadastroView()));
            // }),
//           Future.delayed(const Duration(milliseconds: 500), () {
// // Aqui você pode escrever seu código
//
//             setState(() {
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) =>  CadastroView()),
//                       (route) => false);
//             });
//           }),
        Navigator.pushNamed(context, '/cadastro'),

        child: const Icon(Icons.add),
      ),
    );
  }
}


