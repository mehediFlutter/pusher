import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:pusher_p/push_manager.dart';

class ChatController extends GetxController {
  final PusherManager _pusherManager = Get.put(PusherManager());

  @override
  void onInit() {
    super.onInit();
    _pusherManager.pusherAddListener(onEvent);
    _pusherManager.initPusher();
  }

  List<String> messages = [];
  void onEvent(PusherEvent event) {
    debugPrint("Push EVENT: ${event.eventName}");

    final decodeMessage = ChatMesModelResponse.fromRawJson(event.data as String);
    debugPrint("=== Decode message: ${decodeMessage.message} ===  ");
    debugPrint('=== Receive message ===');
    messages.add(decodeMessage.message ?? '');
    debugPrint('=== message List === $messages');
    update();

    debugPrint("Push DATA: ${event.data}");
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
