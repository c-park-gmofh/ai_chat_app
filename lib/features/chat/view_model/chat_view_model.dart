import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ai_chat_app/features/chat/model/message_model.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class ChatViewModel extends GetxController {
  var messages = <MessageModel>[].obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final Map<String, Color> userColors = {};
  String userName = '';
  var question = 'NASAがひた隠しにしている宇宙人の新情報とは？'.obs;

  late IO.Socket socket;
  ConfettiController? confettiController;

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected to server');
    });

    socket.on('disconnect', (_) {
      print('disconnected from server');
    });

    socket.on('message', (data) {
      final message = MessageModel.fromJson(data);
      messages.add(message);
      _scrollToBottom();
    });

    socket.on('judgment', (data) {
      final judgmentMessage = MessageModel(
        userId: '0',
        userName: '審査員',
        text: 'コメント: ${data['comment']}\nスコア: ${data['score']}',
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
      );
      messages.add(judgmentMessage);
      _scrollToBottom();

      if (data['score'] >= 60) {
        Get.snackbar(
          "おもろい！",
          "高得点を獲得しました！",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        confettiController?.play();
      }
    });
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final message = MessageModel(
      userId: '1',
      userName: userName,
      text: text,
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
    );

    socket.emit('message', message.toJson());

    messages.add(message);
    messageController.clear();
    _scrollToBottom();
  }

  void requestJudgment() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    socket.emit('judge', {
      'userName': userName,
      'question': question.value,
      'message': text,
    });

    // 入力欄をリセット
    messageController.clear();
  }

  void setUserName(String name) {
    userName = name;
  }

  void setQuestion(String newQuestion) {
    question.value = newQuestion;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Color getUserColor(String userName) {
    if (!userColors.containsKey(userName)) {
      final random = Random();
      userColors[userName] = Color.fromARGB(
        255,
        random.nextInt(128) + 128,
        random.nextInt(128) + 128,
        random.nextInt(128) + 128,
      );
    }
    return userColors[userName]!;
  }
}
