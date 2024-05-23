import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_flutter_app/models/usuario.dart';
import 'package:chat_flutter_app/widgets/listview_usuarios.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [
    Usuario(
      name: 'Federico',
      email: 'fleiras18@gmail.com',
      uuid: '1',
      isOnline: true,
    ),
    Usuario(
      name: 'Marcelo',
      email: 'marce@gmail.com',
      uuid: '2',
      isOnline: false,
    ),
    Usuario(
      name: 'Dario',
      email: 'daro@gmail.com',
      uuid: '3',
      isOnline: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Nombre del usuario',
          style: TextStyle(
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
          onPressed: () {},
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
        child: listViewUsuarios(usuarios),
      ),
    );
  }
}
