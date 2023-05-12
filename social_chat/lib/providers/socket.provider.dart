import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  IO.Socket? _socket;

  IO.Socket? get socket {
    return _socket;
  }

  void connect() async {
    final userId = await SharedPreferencesServices.getData("userId");
    _socket = IO.io("http://192.168.0.105:4001");
    _socket?.io.options["transports"] = ["websocket"];
    _socket?.io.options["query"] = "user_id=$userId";
    _socket?.io.options['extraHeaders'] = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ",
    };
    _socket?.onConnect((_) {
      notifyListeners();
    });

    // socket = skt;
  }

  void sendMessage(Map<String, String> payload) async {
    String? userId = await SharedPreferencesServices.getData("userId");
    _socket?.emit("message", {
      "content": payload["content"],
      "chat_id": payload["chatId"],
      "my_id": userId,
    });
  }

  void receiveMessage() {
    // Message? _msg = Message();
    _socket?.on("receive_message", (msg) => print(msg));
    // return _msg;
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
    notifyListeners();
  }
}
