import 'package:flutter/material.dart';
import 'package:my_workout/shared/constants/colors.dart';
import 'package:my_workout/util/size-config/size-config.dart';

class TitleSubtileWidget extends StatelessWidget {
  const TitleSubtileWidget({Key? key}) : super(key: key);

  Container titleSubtitle() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.kThirdColor,
              Colors.transparent,
            ]),
      ),
      height: SizeConfig.safeBlockVertical! * 50,
      width: SizeConfig.safeBlockHorizontal! * 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            // const SizedBox(height: 30),
            // RichText(
            //   text: const TextSpan(
            //       text: 'HARD\t',
            //       style: TextStyle(
            //         fontFamily: "Bebas",
            //         fontSize: 30,
            //         letterSpacing: 5,
            //       ),
            //       children: [
            //         TextSpan(
            //           text: 'ELEMENT',
            //           style: TextStyle(
            //             color: kFirstColor,
            //           ),
            //         )
            //       ]),
            // ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // Text(
                  //   "Sign In",
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Text(
                    "Treine e viva a nova experiência de \nexercitar"
                    " em casa",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return titleSubtitle();
  }
}
