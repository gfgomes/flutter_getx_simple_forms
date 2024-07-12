import 'package:get/get.dart';
import '../models/user.dart';

class UserWithoutFormController extends GetxController {
  var user = User.empty().obs;
  var userList = <User>[].obs;

  // Campos de validação
  var nameError = ''.obs;
  var genderError = ''.obs;

  void setName(String name) {
    user.update((val) {
      val?.name = name;
    });
    validateName();
  }

  void setGender(String? gender) {
    user.update((val) {
      val?.gender = gender;
    });
    validateGender();
  }

  void validateName() {
    if (user.value.name == null || user.value.name!.isEmpty) {
      nameError.value = 'Nome é obrigatório';
    } else {
      nameError.value = '';
    }
  }

  void validateGender() {
    if (user.value.gender == null || user.value.gender!.isEmpty) {
      genderError.value = 'Gênero é obrigatório';
    } else {
      genderError.value = '';
    }
  }

  bool validateForm() {
    validateName();
    validateGender();
    return nameError.value.isEmpty && genderError.value.isEmpty;
  }

  bool saveUser() {
    bool formIsValid = validateForm();
    if (formIsValid) {
      userList.add(User(name: user.value.name, gender: user.value.gender));
      clearUser();
      return true;
    }
    return false;
  }

  void clearUser() {
    user.update((val) {
      val?.name = null;
      val?.gender = null;
    });
    clearErrors();
  }

  void clearErrors() {
    nameError.value = '';
    genderError.value = '';
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }
}
