import 'package:get/get.dart';

class UserViewModel extends GetxController {
  var userId = '1'.obs;
  var userName = ''.obs;

  void setUserId(String id) {
    userId.value = id;
  }

  void setUserName(String name) {
    userName.value = name;
  }
}
