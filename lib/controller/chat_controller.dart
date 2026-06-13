import 'dart:convert';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:pusher_p/push_manager.dart';

class ChatController extends GetxController {
  final PusherManager pusherManager = Get.put(PusherManager());

  @override
  void onInit() {
    super.onInit();
    pusherManager.initPusher();
    pusherManager.pusherAddListener(onEvent);
  }

  List<String> messages = [];
  void onEvent(PusherEvent event) {
    final decodeMessage = ChatMesModelResponse.fromRawJson(event.data);

    messages.add(decodeMessage.message ?? '');
    update();
  }
}

class ChatMesModelResponse {
  String? message;

  ChatMesModelResponse({this.message});

  factory ChatMesModelResponse.fromRawJson(String str) =>
      ChatMesModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatMesModelResponse.fromJson(Map<String, dynamic> json) =>
      ChatMesModelResponse(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
