import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_p/controller/chat_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(ChatController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Center(
                  child: Text(
                    '${controller.messages.length}',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: controller.messages.length,
                //     itemBuilder: (context, index) {
                //       final item = controller.messages[index];
                //       return Text(item.message, style: TextStyle(fontSize: 20));
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
