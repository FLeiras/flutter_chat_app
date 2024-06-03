import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter_app/models/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_flutter_app/services/services.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usersService = UsersService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late List<User> allUsers = [];

  @override
  void initState() {
    _usersCharge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
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
            socketService.disconnect();
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : const Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => {
          _usersCharge(),
        },
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
        ),
        child: usersListView(allUsers),
      ),
    );
  }

  ListView usersListView(List<User> users) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usersListTitle(users[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _usersListTitle(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          user.name.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: _statusDecoration(user),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.recipientUser = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  BoxDecoration _statusDecoration(User user) {
    return BoxDecoration(
      color: user.online ? Colors.green[300] : Colors.red,
      borderRadius: BorderRadius.circular(100),
    );
  }

  _usersCharge() async {
    allUsers = await usersService.getUsers();
    setState(() {});

    _refreshController.refreshCompleted();
  }
}
