import 'package:flutter_getx_simple_form/models/user.dart';
import 'package:get/get.dart';

class UserControllerV1 extends GetxController {
  Rx<User> user = User.empty().obs;
  RxList<User> userList = <User>[].obs;

  void setName(String? name) {
    user.update((val) {
      val?.name = name;
    });
  }

  String getUserName() {
    return user.value.name ?? '';
  }

  void setGender(String? gender) {
    user.update((val) {
      val?.gender = gender;
    });
  }

  void saveUser() {
    userList.add(User(name: user.value.name, gender: user.value.gender));
    clearUser();
  }

  void clearUser() {
    user.update((val) {
      val?.name = null;
      val?.gender = null;
    });
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }
}
