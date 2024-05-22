import 'package:flutter/material.dart';

import 'package:chat_flutter_app/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(
                  title: 'Registrate',
                ),
                _Form(),
                const Labels(
                  route: 'login',
                  subText: '¿Ya tienes una cuenta?',
                  text: 'Ingresa ahora',
                ),
                const Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            hintText: 'Nombre',
            icon: Icons.perm_identity,
            textController: nameCtrl,
          ),
          CustomInput(
            hintText: 'Email',
            icon: Icons.email_outlined,
            textController: emailCtrl,
          ),
          CustomInput(
            hintText: 'Contraseña',
            icon: Icons.password_outlined,
            textController: passCtrl,
            isVisible: true,
          ),
          BlueButton(
            onPress: () {},
            btnText: 'Ingrese',
          ),
        ],
      ),
    );
  }
}
