// lib/controllers/user_controller_v1.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserControllerV1 extends GetxController {
  var user = User.empty().obs;
  var userList = <User>[].obs;

  // TextEditingController para o campo de nome
  TextEditingController nameController = TextEditingController();

  void setName(String name) {
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
    nameController.clear();
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
