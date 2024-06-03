import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter_app/widgets/widgets.dart';
import 'package:chat_flutter_app/helpers/show_alert.dart';
import 'package:chat_flutter_app/services/auth_service.dart';
import 'package:chat_flutter_app/services/socket_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  title: 'Messenger',
                ),
                _Form(),
                const Labels(
                  route: 'register',
                  text: 'Creala ahora!',
                  subText: '¿No tienes cuenta?',
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

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            hintText: 'Email',
            icon: Icons.email_outlined,
            textController: emailCtrl,
          ),
          CustomInput(
            hintText: 'Password',
            icon: Icons.password_outlined,
            textController: passCtrl,
            isVisible: true,
          ),
          BlueButton(
            onPressed: authService.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      // ignore: use_build_context_synchronously
                      showAlert(context, 'Login incorrecto',
                          'Revise las credenciales');
                    }
                  },
            btnText: 'Ingrese',
            color: authService.authenticating
                ? Colors.grey[400]!
                : Colors.blue[400]!,
          ),
        ],
      ),
    );
  }
}
