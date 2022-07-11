import 'package:flutter/material.dart';
import 'package:my_workout/util/size-config/size-config.dart';

class BackGroundImageWidget extends StatelessWidget {
  const BackGroundImageWidget({Key? key}) : super(key: key);

  Container backgroundImage() {
    return Container(
      height: SizeConfig.safeBlockVertical! * 45,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imagens/black/23.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return backgroundImage();
  }
}
