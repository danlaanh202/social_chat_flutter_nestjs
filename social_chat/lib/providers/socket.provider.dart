import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  List<IO.Socket> _previousConnections = [];
  IO.Socket? _socket;

  IO.Socket? get socket {
    return _socket;
  }

  void connect() async {
    print("connect");
    if (_socket != null && _socket!.connected) {
      // Socket is already connected
      return;
    } // Ngắt kết nối các kết nối khác trước khi kết nối mới

    final userId = await SharedPreferencesServices.getData("userId");
    _socket = IO.io(
      "http://192.168.0.105:4000/",
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .setQuery({"user_id": userId})
          .disableReconnection()
          .enableForceNew()
          .disableAutoConnect()
          .build(),
    );

    print("...");
    _socket?.connect();
    _socket?.onConnect((_) {
      // print(_socket?.id);
      notifyListeners();
    });
    _socket?.onConnectError((data) {
      print("error");
      notifyListeners();
    });
    _socket?.onDisconnect((data) => print("dis"));

    // Lưu trữ kết nối hiện tại vào danh sách
    if (_socket != null) {
      _previousConnections.add(_socket!);
    }
  }

  void sendMessage(Map<String, String> payload) async {
    print(payload["content"]);
    String? userId = await SharedPreferencesServices.getData("userId");
    print(userId);
    _socket?.emit("message", {
      "content": payload["content"],
      "chat_id": payload["chatId"],
      "my_id": userId,
    });
  }

  Future<Message?> receiveMessage() async {
    Message? _msg = Message();

    _socket?.on("message_receive_room", (msg) => _msg = Message.fromJson(msg));
    return _msg;
  }

  void disconnect() {
    for (var connection in _previousConnections) {
      connection.disconnect();
      connection.dispose();
    }
    _previousConnections.clear();

    _socket?.disconnect();
    _socket?.dispose();

    _socket = null;
    notifyListeners();
  }
}
