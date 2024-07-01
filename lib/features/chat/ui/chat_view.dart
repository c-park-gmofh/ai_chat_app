import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ai_chat_app/features/chat/view_model/chat_view_model.dart';
import 'package:confetti/confetti.dart';

class ChatView extends StatelessWidget {
  final String userName;
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  ChatView({required this.userName}) {
    final ChatViewModel viewModel = Get.put(ChatViewModel());
    viewModel.setUserName(userName);
    viewModel.confettiController = _confettiController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お題修正'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Get.defaultDialog(
              title: "新しいお題を入力してください",
              content: TextField(
                onSubmitted: (value) {
                  final controller = Get.find<ChatViewModel>();
                  controller.setQuestion(value);
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GetX<ChatViewModel>(
            builder: (controller) {
              return Column(
                children: [
                  // お題を最初に表示
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.amber[100],
                    child: Text(
                      controller.question.value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final isMe = message.userName == controller.userName;
                        final alignment = isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start;
                        final color = isMe
                            ? Colors.blue[100]
                            : controller.getUserColor(message.userName);
                        final textColor =
                            isMe ? Colors.blue[900] : Colors.black;
                        final time =
                            DateFormat('HH:mm').format(message.timestamp);

                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: alignment,
                            children: [
                              Text(
                                message.userName,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                constraints: BoxConstraints(
                                  minWidth: 0,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                child: Column(
                                  crossAxisAlignment: alignment,
                                  children: [
                                    Text(
                                      message.text,
                                      style: TextStyle(color: textColor),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            decoration: InputDecoration(hintText: 'メッセージ入力...'),
                            onSubmitted: (value) => controller.sendMessage(),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => controller.sendMessage(),
                        ),
                        IconButton(
                          icon: Icon(Icons.tag_faces_rounded),
                          onPressed: () {
                            controller.requestJudgment();
                            controller.messageController.clear(); // 入力欄をリセット
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -3.14 / 2, // vertical
              shouldLoop: false,
              numberOfParticles: 50, // 増やした花びらの量
              colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange],
            ),
          ),
        ],
      ),
    );
  }
}
