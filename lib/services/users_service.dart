import 'package:http/http.dart' as http;

import 'package:chat_flutter_app/models/models.dart';
import 'package:chat_flutter_app/globals/environment.dart';
import 'package:chat_flutter_app/services/auth_service.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final token = await AuthService.getToken();

      if (token == null) {
        return [];
      } else {
        final resp = await http.get(
          Uri.parse('${Environments.apiUrl}/users/all'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );

        final userResp = usersResponseFromJson(resp.body);

        return userResp.users;
      }
    } catch (e) {
      return [];
    }
  }
}
