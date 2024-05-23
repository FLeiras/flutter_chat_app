import 'package:flutter/material.dart';

import 'package:chat_flutter_app/models/usuario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

ListView listViewUsuarios(List<Usuario> usuarios) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (_, i) => _usuarioListTitle(usuarios[i]),
    separatorBuilder: (_, i) => const Divider(),
    itemCount: usuarios.length,
  );
}

ListTile _usuarioListTitle(Usuario usuario) {
  return ListTile(
    title: Text(usuario.name),
    subtitle: Text(usuario.email),
    leading: CircleAvatar(
      backgroundColor: Colors.blue[100],
      child: Text(
        usuario.name.substring(0, 2),
      ),
    ),
    trailing: Container(
      width: 10,
      height: 10,
      decoration: _statusDecoration(usuario),
    ),
  );
}

BoxDecoration _statusDecoration(Usuario usuario) {
  return BoxDecoration(
    color: usuario.isOnline ? Colors.green[300] : Colors.red,
    borderRadius: BorderRadius.circular(100),
  );
}

Future<dynamic> cargarUsuarios(RefreshController refreshController) async {
  await Future.delayed(
    const Duration(milliseconds: 1500),
  );
  refreshController.refreshCompleted();
}
