import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_flutter_app/models/models.dart';
import 'package:chat_flutter_app/services/services.dart';
import 'package:chat_flutter_app/globals/environment.dart';

class ChatService with ChangeNotifier {
  late User? recipientUser;

  ChatService({
    this.recipientUser,
  });

  Future<List<Msg>> getChat(String userID) async {
    try {
      final token = await AuthService.getToken();

      if (token == null) {
        return [];
      } else {
        final resp = await http.get(
          Uri.parse('${Environments.apiUrl}/messages/$userID'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );

        final msgResp = messagesResponseFromJson(resp.body);

        return msgResp.msg;
      }
    } catch (e) {
      return [];
    }
  }
}
