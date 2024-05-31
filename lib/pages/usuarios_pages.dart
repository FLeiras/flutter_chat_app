import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter_app/models/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_flutter_app/services/auth_service.dart';
import 'package:chat_flutter_app/widgets/listview_usuarios.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<User> users = [
    User(
      name: 'Federico',
      email: 'fleiras18@gmail.com',
      online: true,
    ),
    User(
      name: 'Marcelo',
      email: 'marce@gmail.com',
      online: false,
    ),
    User(
      name: 'Dario',
      email: 'daro@gmail.com',
      online: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user.name,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            /* child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ), */
            child: const Icon(
              Icons.offline_bolt,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => cargarUsuarios(_refreshController),
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
        ),
        child: listViewUsuarios(users),
      ),
    );
  }
}
