import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

class UserController extends GetxController {
  var nameController = TextEditingController().obs;
  Rx<String?> gender = ''.obs;
  var userList = <User>[].obs;

  // Campos de validação
  // var nameError = ''.obs;
  // var genderError = ''.obs;

  void setName(String name) {
    nameController.value.text = name;
    //validateName();
  }

  void setGender(String? selectedGender) {
    gender.value = selectedGender ?? '';
    //validateGender();
  }

  // void validateName() {
  //   if (nameController.value.text.isEmpty) {
  //     nameError.value = 'Nome é obrigatório';
  //   } else {
  //     nameError.value = '';
  //   }
  // }

  // void validateGender() {
  //   if (gender.value!.isEmpty) {
  //     genderError.value = 'Gênero é obrigatório';
  //   } else {
  //     genderError.value = '';
  //   }
  // }

  // bool validateForm() {
  //   validateName();
  //   validateGender();
  //   return nameError.value.isEmpty && genderError.value.isEmpty;
  // }

  void saveUser() {
    // if (validateForm()) {
    //   userList.add(User(name: nameController.value.text, gender: gender.value));
    //   clearUser();
    // }

    userList.add(User(name: nameController.value.text, gender: gender.value));
    clearUser();
  }

  void clearUser() {
    nameController.value.clear();
    gender.value = '';
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }
}
