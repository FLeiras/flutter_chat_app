import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  final bool ok;
  final List<Msg> msg;

  MessagesResponse({
    required this.ok,
    required this.msg,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
      };
}

class Msg {
  final String of;
  final String msgFor;
  final String msg;
  final DateTime createdAt;
  final DateTime updatedAt;

  Msg({
    required this.of,
    required this.msgFor,
    required this.msg,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        of: json["of"],
        msgFor: json["for"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "of": of,
        "for": msgFor,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
