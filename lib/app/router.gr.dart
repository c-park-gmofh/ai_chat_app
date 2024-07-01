// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    UserViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: UserView(),
      );
    },
    ChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ChatViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ChatView(userName: args.userName),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          UserViewRoute.name,
          path: '/',
        ),
        RouteConfig(
          ChatViewRoute.name,
          path: '/chat-view',
        ),
      ];
}

/// generated route for
/// [UserView]
class UserViewRoute extends PageRouteInfo<void> {
  const UserViewRoute()
      : super(
          UserViewRoute.name,
          path: '/',
        );

  static const String name = 'UserViewRoute';
}

/// generated route for
/// [ChatView]
class ChatViewRoute extends PageRouteInfo<ChatViewRouteArgs> {
  ChatViewRoute({required String userName})
      : super(
          ChatViewRoute.name,
          path: '/chat-view',
          args: ChatViewRouteArgs(userName: userName),
        );

  static const String name = 'ChatViewRoute';
}

class ChatViewRouteArgs {
  const ChatViewRouteArgs({required this.userName});

  final String userName;

  @override
  String toString() {
    return 'ChatViewRouteArgs{userName: $userName}';
  }
}
