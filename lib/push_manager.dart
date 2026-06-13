import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:pusher_p/environment.dart';

class PusherManager {
  bool isConnedted = false;
  final List<void Function(PusherEvent)> _listeners = [];
  // -----------------------------
  late PusherChannelsFlutter pusher;
  bool isConnected = false;
  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await _disconnect();
    try {
      await pusher.init(
        apiKey: Environment.pusherApiKey,
        cluster: Environment.pusherApiCluster,

        onConnectionStateChange: _onConnectionStateChange,
        onError: _onError,
        onEvent: _dispatchEvent,
      );

      await pusher.subscribe(channelName: 'chat');
      await pusher.connect();
    } catch (e) {
      debugPrint(" === Pusher INIT ERROR: $e");
    }
  }

  // -----------------------------
  // DISCONNECT
  // -----------------------------
  Future<void> _disconnect() async {
    try {
      if (pusher.connectionState.toLowerCase() != 'disconnected') {
        await pusher.disconnect();
      }
    } catch (_) {}
  }

  // -----------------------------
  // CONNECTION STATE
  // -----------------------------
  void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("=== Pusher state: $previousState → $currentState");

    isConnected = currentState == "CONNECTED";
  }

  // -----------------------------
  // ERROR HANDLER
  // -----------------------------
  void _onError(String message, int? code, dynamic e) {
    debugPrint("Pusher ERROR: $message | code: $code | error: $e");
  }

  // -----------------------------
  // EVENT LISTENER
  // -----------------------------
  void _dispatchEvent(PusherEvent event) {
    debugPrint("Pusher EVENT: ${event.eventName}");
    debugPrint("Pusher DATA: ${event.data}");
    for (var listener in _listeners) {
      listener(event);
    }
  }

  void pusherAddListener(void Function(PusherEvent) listener) {
    if (!_listeners.contains(listener)) _listeners.add(listener);
  }
}
