import 'package:ai_chat_app/features/chat/ui/chat_view.dart';
import 'package:ai_chat_app/features/user/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final UserViewModel userViewModel = Get.put(UserViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('君の名は?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'お名前'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  userViewModel.setUserName(_nameController.text);
                  Get.to(() => ChatView(userName: _nameController.text));
                }
              },
              child: Text('大喜利チャット場へ入場'),
            ),
          ],
        ),
      ),
    );
  }
}
