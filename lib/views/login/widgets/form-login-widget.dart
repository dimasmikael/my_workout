import 'package:flutter/material.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget(this.controllerEmail, this.controllerSenha, {Key? key})
      : super(key: key);
  final TextEditingController? controllerEmail;
  final TextEditingController? controllerSenha;

  Column formLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(color: const Color(0xFF707070), fontSize: 18),
        ),
        TextField(
          controller: controllerEmail,
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Email",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF707070),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF707070),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Senha",
          style: TextStyle(color: const Color(0xFF707070), fontSize: 18),
        ),
        TextField(
          controller: controllerSenha,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: "Senha",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF707070),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF707070),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return formLogin();
  }
}
