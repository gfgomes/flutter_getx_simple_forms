import 'package:flutter_getx_simple_form/models/user.dart';
import 'package:get/get.dart';

class UserControllerV1 extends GetxController {
  var user = User.empty().obs;
  var userList = <User>[].obs;

  // Campos de validação
  var nameError = ''.obs;
  var genderError = ''.obs;

  void setName(String name) {
    user.update((val) {
      val?.name = name;
    });
    //validateName();
  }

  void setGender(String? gender) {
    user.update((val) {
      val?.gender = gender;
    });
    //validateGender();
  }

  // void validateName() {
  //   if (user.value.name!.isEmpty) {
  //     nameError.value = 'Nome é obrigatório';
  //   } else {
  //     nameError.value = '';
  //   }
  // }

  void validateGender() {
    if (user.value.gender!.isEmpty) {
      genderError.value = 'Gênero é obrigatório';
    } else {
      genderError.value = '';
    }
  }

  // bool validateForm() {
  //   validateName();
  //   validateGender();
  //   return nameError.value.isEmpty && genderError.value.isEmpty;
  // }

  void saveUser() {
    // if (validateForm()) {
    //   userList.add(User(name: user.value.name, gender: user.value.gender));
    //   clearUser();
    // }
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
