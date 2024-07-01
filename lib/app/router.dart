import 'package:ai_chat_app/features/chat/ui/chat_view.dart';
import 'package:ai_chat_app/features/user/ui/user_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: UserView, initial: true),
    AutoRoute(page: ChatView),
  ],
)
class AppRouter extends _$AppRouter {}
